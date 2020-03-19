define([
    'backbone',
    'moment'
], function (Backbone) {

    const WorldPopulationDistrictSummary = Backbone.Model.extend({
        urlRoot: postgresUrl + 'mv_flood_event_world_pop_district_summary',
        url: function () {
            return `${this.urlRoot}?district_id=eq.${this.attr('district_id')}`
        }
    });

    return Backbone.Collection.extend({
        model: WorldPopulationDistrictSummary,
        urlRoot: postgresUrl + 'mv_flood_event_world_pop_district_summary',
        url: function () {
            return this.urlRoot;
        }
    });
});
