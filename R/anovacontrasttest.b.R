
# This file is a generated template, your changes will not be overwritten

anovacontrasttestClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "anovacontrasttestClass",
    inherit = anovacontrasttestBase,
    private = list(
        .run = function() {


            self$results$text$setContent(anova_contrast_demo())

        })
)
