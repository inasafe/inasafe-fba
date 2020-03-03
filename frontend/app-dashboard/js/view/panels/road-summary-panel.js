define([
    'backbone',
    'jquery',
    'js/view/panels/summary-panel.js'
], function (Backbone, $, SummaryPanel) {

    return SummaryPanel.extend({
        _panel_key: 'road',
        primary_exposure_key: 'residential',
        primary_exposure_label: 'Residential Roads',
        other_category_exposure_label: 'Other Roads Category'
    });
});
