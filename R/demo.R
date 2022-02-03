anova_contrast_demo <- function() {

    mydata <- data.frame(
        label = as.factor(
                c(
                    "Aden (1993)",
                    "Buggs (1995)",
                    "Crazed (1999)",
                    "Dudley (2003)",
                    "Evers (2005)",
                    "Fox (2009)",
                    "Mine (2011)"
                )
        ),
        yi = c(
            454,
            317,
            430,
            525,
            479,
            387,
            531

        ),
        vi = c(
            840.1666667,
            3566.285714,
            938.45,
            8450,
            1481.142857,
            2094.230769,
            3016.055556
        ),
        moderator = as.factor(
            c(
                "90s",
                "90s",
                "90s",
                "00s",
                "00s",
                "00s",
                "00s"
            )
        ),
        weights = c(
            41.27574205,
            19.10591099,
            39.61834697,
            11.14928973,
            35.30133444,
            29.65063844,
            23.89873739
        )
    )

    yi = "yi"
    vi = "vi"
    moderator = "moderator"
    conf_level = .95

    FEgroups <- metafor::rma(
        data = mydata,
        yi = yi,
        vi = vi,
        mods = ~ moderator -1,
        method="FE",
        level = conf_level * 100
    )

    contrast = rep(x = 0, times = length(FEgroups$b))
    contrast[1] = 1
    contrast[2] = -1

    contrasts <- list(
        Comparison = contrast,
        Reference = contrast,
        Difference = contrast
    )
    # Filter to create comparison and reference only subsets
    contrasts$Comparison[which(contrasts$Comparison < 0)] <- 0
    contrasts$Reference[which(contrasts$Reference > 0)] <- 0
    contrasts$Reference <- abs(contrasts$Reference)

    res <- list()

    for (x in 1:length(contrasts)) {
        res[[x]] <- stats::anova(FEgroups, X = contrasts[[x]])
    }

    return(res)

}
