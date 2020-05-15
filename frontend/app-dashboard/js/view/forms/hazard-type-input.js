/**
 * View for handling hazard type input on a form
 */
define([
    'backbone',
    'js/model/hazard_type.js',
    'js/model/depth_class.js',], function (Backbone, HazardTypeCollection, HazardClassCollection) {
    return Backbone.View.extend({
        classesByType: {},
        initialize: function ($form) {
            this.classesByType = {}
            this.$input = $form.find('select[name$="hazard_type"]')
            this.$classGuide = $form.find('.hazard-input-guide')
            this.$guideToggler = this.$classGuide.find('.fa')
            this.$classGuideContent = $form.find('.hazard-input-guide-content')

            this.initData()
            this.initEventListener()
        },
        /** Initiate data for hazard selection
         */
        initData: function () {
            // get hazard type list
            const that = this
            let typeCollection = new HazardTypeCollection()
            typeCollection.fetch().then(function (data) {
                data.forEach(function (value) {
                    that.$input.append(`<option value="${value.id}">${value.name}</option>`)
                });
            }).catch(function (data) {
                console.log('Hazard type request failed');
                console.log(data);
            });

            // get hazard class list
            let classCollection = new HazardClassCollection()
            classCollection.fetch().then(function (data) {
                data.map(x => {
                    if (!x.hazard_type) {
                        x.hazard_type = 1
                    }
                    if (!that.classesByType[x.hazard_type]) {
                        that.classesByType[x.hazard_type] = []
                    }
                    that.classesByType[x.hazard_type].push(x.id)

                    // append the data
                    if (that.$classGuideContent.find(`#hazard-type-${x.hazard_type}`).length === 0) {
                        that.$classGuideContent.append('' +
                            `<table style="width:100%; display: none" id="hazard-type-${x.hazard_type}">` +
                            '   <tr><th>class</th><th>description</th></tr>' +
                            ' </table>')
                    }
                    that.$classGuideContent.find(`#hazard-type-${x.hazard_type}`).append(
                        `<tr><td>${x.id}</td><th>${x.label}</th></tr>`
                    )
                });
                that.$classGuideContent.find(`#hazard-type-${that.$input.val()}`).show()
            }).catch(function (data) {
                console.log('Hazard type request failed');
                console.log(data);
            });
        },
        /** Initiate event listener
         */
        initEventListener: function () {
            // event listener for guide toggler
            const that = this;
            this.$guideToggler.click(function () {
                that.$classGuideContent.slideToggle()
                if ($(this).hasClass("fa-caret-square-o-down")) {
                    $(this).addClass("fa-caret-square-o-up").removeClass("fa-caret-square-o-down")
                } else {
                    $(this).addClass("fa-caret-square-o-down").removeClass("fa-caret-square-o-up")
                }
            })
            this.$input.change(function () {
                that.$classGuideContent.find('table').hide()
                that.$classGuideContent.find(`#hazard-type-${$(this).val()}`).show()
            })
        },
        /** Get current classes
         */
        returnCurrentClasses: function () {
            return this.classesByType[this.$input.val()]
        },
    });
});