define([
    'backbone',
    'jquery',
], function (Backbone, $) {

    return Backbone.View.extend({
        _panel_key: 'generic',
        stats_data: [],
        initialize: function(panel_dashboard){
            this.panel_dashboard = panel_dashboard;
        },
        reset: function(){
            this.stats_data = []
        },
        panelKey: function(){
            return this._panel_key;
        },
        renderChartElement: function (data, exposure_name) {
            exposure_name = exposure_name ? exposure_name : this.panelKey();
            let $parentWrapper = $(`#chart-score-panel .tab-${exposure_name}`);
            $parentWrapper.find('.summary-chart').remove();
            $parentWrapper.find('.panel-chart').html('<canvas class="summary-chart" style="height: 250px"></canvas>');
            $parentWrapper.find('.summary-chart-residential').remove();
            $parentWrapper.find('.panel-chart-residential').html('<canvas class="summary-chart-residential" style="height: 100px"></canvas>');

            let total_building_array = [];
            let graph_data = [];
            let flood_graph_data = [];
            let backgroundColours = [];
            let total_flooded_count_key = `flooded_${exposure_name}_count`;
            let total_count_key = `${exposure_name}_count`;
            let unlisted_key = [
                'id', 'flood_event_id', 'total_vulnerability_score', total_flooded_count_key, total_count_key,
                'village_id', 'name', 'region', 'district_id', 'sub_district_id', 'sub_dc_code', 'village_code', 'dc_code',
                'trigger_status'
            ];
            let residential_flood_data = [];
            let residential_data = [];
            let flooded_count_key_suffix = `_flooded_${exposure_name}_count`;
            let total_count_key_suffix = `_${exposure_name}_count`;
            let label = [];
            for (let key in data) {
                let is_in_unlisted = unlisted_key.indexOf(key) > -1;
                if(is_in_unlisted) { continue; }

                let is_flooded_count = key.endsWith(flooded_count_key_suffix);
                let is_residential = key.indexOf('residential') > -1;

                if(is_residential && is_flooded_count){
                    // Record residential data for pie chart
                    residential_flood_data = data[key];
                    residential_data = data[key.replace(flooded_count_key_suffix, total_count_key_suffix)];
                }
                else if(is_flooded_count){
                    // Record flooded data for bar chart
                    let breakdown_key = key.replace(flooded_count_key_suffix, '');
                    let total_count_key = key.replace(flooded_count_key_suffix, total_count_key_suffix);
                    flood_graph_data.push({
                        y: breakdown_key,
                        x: data[key]
                    })

                    // Figure out non flooded count
                    let non_flooded_count = data[total_count_key] - data[key];
                    if(isNaN(non_flooded_count)){
                        non_flooded_count = 0;
                    }
                    graph_data.push({
                        y: breakdown_key,
                        x: non_flooded_count
                    });

                    // Figure out total count
                    total_building_array.push({
                        key: breakdown_key,
                        value: data[total_count_key]
                    });
                }

                backgroundColours.push('#82B7CA');
            }

            // Sort descending
            total_building_array.sort(function (a, b) {
                return b.value - a.value
            });

            for(let i in total_building_array){
                let o = total_building_array[i]
                let is_residential = o.key.indexOf('residential') > -1;
                if(! is_residential){
                    label.push(o.key);
                }
            }

            graph_data.sort(function (a, b) {
                return label.indexOf(a.y) - label.indexOf(b.y);
            });

            flood_graph_data.sort(function (a, b) {
                return label.indexOf(a.y) - label.indexOf(b.y);
            });

            let humanLabel = [];
            for (let i = 0; i < label.length; i++) {
                humanLabel.push(toTitleCase(label[i].replace('_', ' ')))
            }

            let ctxResidential = $parentWrapper.find('.summary-chart-residential').get(0).getContext('2d');
            let datasetsResidential = {
                labels: ["Not Flooded", "Flooded"],
                datasets: [{
                    data: [residential_data - residential_flood_data, residential_flood_data],
                    backgroundColor: ['#e5e5e5', '#82B7CA']
                }]
            };
            let ctx = $parentWrapper.find('.summary-chart').get(0).getContext('2d');
            let datasets = {
                labels: humanLabel,
                datasets: [
                    {
                        label: "Not Flooded",
                        data: graph_data
                    }, {
                        label: "Flooded",
                        data: flood_graph_data,
                        backgroundColor: backgroundColours
                    }]
            };

            let total_vulnerability_score = data['total_vulnerability_score'] ? data['total_vulnerability_score'].toFixed(2) : 0;
            $parentWrapper.find('.vulnerability-score').html(total_vulnerability_score);
            $parentWrapper.find('.exposed-count').html(data[total_flooded_count_key]);

            this.renderChartData(datasets, ctx, 'Residential Buildings', datasetsResidential, ctxResidential, 'Other Buildings');
        },
        renderChartData: function (datasets, ctx, title, datasetsResidential, ctxResidential, title2) {
            new Chart(ctxResidential, {
                type: 'pie',
                data: datasetsResidential,
                options: {
                    legend: {
                        display: true
                    },
                    title: {
                        display: true,
                        text: title
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        labels: {
                            render: 'value',
                            position: 'outside',
                            textMargin: 4
                        }
                    }
                }
            });

            new Chart(ctx, {
                type: 'horizontalBar',
                data: datasets,
                options: {
                    legend: {
                        display: true
                    },
                    scales: {
                        xAxes: [{
                            stacked: true,
                            gridLines: {
                                display:false
                            },
                            ticks: {
                                min: 0
                            }
                        }],
                        yAxes: [{
                            stacked: true,
                            gridLines: {
                                display:false
                            },
                        }]
                    },
                    title: {
                        display: true,
                        text: title2
                    },
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        },
    });
});
