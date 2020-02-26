define([
    'backbone',
    'jquery',
    'js/view/panels/summary-panel.js'
], function (Backbone, $, SummaryPanel) {

    return SummaryPanel.extend({
        _panel_key: 'population',
        primary_exposure_key: 'affected',
        primary_exposure_label: 'Affected people',
        other_category_exposure_label: 'Demographic',
        renderChartElement: function (data, exposure_name) {
            data['affected_flooded_population_count'] = data['flooded_population_count'];
            data['affected_population_count'] = data['population_count'];
            SummaryPanel.prototype.renderChartElement.call(this, data, exposure_name);
        }
    });
});
