define([
    'backbone',
    'moment'
], function (Backbone) {

    const WorldPopulationVillageSummary = Backbone.Model.extend({
        urlRoot: postgresUrl + 'mv_flood_event_world_pop_village_summary',
        url: function () {
            return `${this.urlRoot}?district_id=eq.${this.attr('district_id')}`
        }
    });

    return Backbone.Collection.extend({
        model: WorldPopulationVillageSummary,
        urlRoot: postgresUrl + 'mv_flood_event_world_pop_village_summary',
        url: function () {
            return this.urlRoot;
        }
    });
});
