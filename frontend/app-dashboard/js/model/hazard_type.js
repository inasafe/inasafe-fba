/**
 * Hazard type model
 * - id
 * - name
 */
define([
    'backbone',
    'moment'
], function (Backbone) {

    const HazardType = Backbone.Model.extend({
        urlRoot: postgresUrl + 'hazard_type',
        url: function () {
            return `${this.urlRoot}?id=eq.${this.id}`
        }
    });

    return Backbone.Collection.extend({
        model: HazardType,
        urlRoot: postgresUrl + 'hazard_type?order=name',
        url: function () {
            return this.urlRoot;
        }
    });
});