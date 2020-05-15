define([
    'backbone'],
    /**
     * attributes:
     * - id
     * - label
     * - max_m
     * - min_m
     */
    function (Backbone) {
    const DepthClass = Backbone.Model.extend({
        urlRoot: postgresUrl + 'hazard_class',

        url: function(){
            return `${this.urlRoot}?id=eq.${this.id}`;
        }
    });

    return Backbone.Collection.extend({
        model: DepthClass,
        urlRoot: postgresUrl + 'hazard_class?order=id',
        url: function () {
            return this.urlRoot
        }
    });
})
