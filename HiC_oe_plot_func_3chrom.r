HiC_oe_plot_func_3chrom <- function(sample_x_balanced_tri_oe,chromdata,chrom1,chrom2,chrom3,mincount)
{
    c1_1 <- subset(chromdata, chr ==chrom1)$add
    c1_2 <- subset(chromdata, chr ==chrom1)$chromlength
    c2_1 <- subset(chromdata, chr ==chrom2)$chromlength
    c3_1 <- subset(chromdata, chr ==chrom3)$chromlength
    gg88 <- ggplot(subset(sample_x_balanced_tri_oe, count > mincount), aes(x=genome_pos1, y = genome_pos2, color=log2_oe )) + 
        geom_point(size=0.1,shape=18) + 
        theme_bw() + 
        scale_colour_gradientn(colours=c("mediumblue","white", "red3"), na.value="white", limits = c(-3,3)) + 
        scale_x_continuous(limits = c(c1_1,(c1_1+c1_2+c2_1+c3_1)), expand = c(0.001,0.001)) + 
        scale_y_continuous(limits = c(c1_1,(c1_1+c1_2+c2_1+c3_1)), expand = c(0.001,0.001))+ 
        theme(axis.text.y=element_text(angle=90, hjust=0.5)) + 
        geom_vline(xintercept =c(c1_1,(c1_1+c1_2)), size=0.5,color="maroon4" )+ 
        geom_vline(xintercept =c((c1_1+c1_2),(c1_1+c1_2)), size=0.5,color="maroon4" )+ 
        geom_hline(yintercept =c((c1_1+c1_2), (c1_1+c1_2+c2_1+c3_1)), size=0.5,color="maroon4" )+ 
        geom_hline(yintercept =c((c1_1+c1_2),(c1_1+c1_2)), size=0.5,color="maroon4" ) +
        geom_hline(yintercept =c((c1_1+c1_2+c2_1),(c1_1+c1_2+c2_1+c3_1)), size=0.5,color="maroon4" ) +
        geom_hline(yintercept =c(c1_1,(c1_1+c1_2+c2_1+c3_1)), size=0.5,color="maroon4" ) +
        theme_void() + 
        theme(legend.position = "none", plot.margin = unit(c(2, 2, 2, 2), "cm"))
    return(gg88)
}