#requires ineq
#requires tidyverse

obs_vs_exp_all_trans <- function(working_dir, expected_trans, min_oe, sig_oe, xx) {
    setwd(working_dir)
    rm(dataset1)
    file_list <- list.files()
    dataset1 <- matrix(ncol=6, nrow=length(file_list))
    colnames(dataset1) <- c("compartment", "gini_start1", "gini_start2", "max_oe", "gini_all", "frac_sig_oe")
    for (i in 1:length(file_list)){
        trans_a_b <- read.delim(file_list[i])
        Sample_11_101819_trans_exp1 <- expected_trans
        Sample_11_101819_trans_exp2 <- expected_trans
        Sample_11_101819_trans_exp1$diagonal <- paste("c", Sample_11_101819_trans_exp1$chrom2, "c", Sample_11_101819_trans_exp1$chrom1, sep='_')
        Sample_11_101819_trans_exp2$diagonal <- paste("c", Sample_11_101819_trans_exp2$chrom1, "c", Sample_11_101819_trans_exp2$chrom2, sep='_')
        Sample_11_101819_trans_exp <- rbind(Sample_11_101819_trans_exp1, Sample_11_101819_trans_exp2)
        Sample_11_101819_trans_exp_smol <- Sample_11_101819_trans_exp[,c(3,4,6,8)]
        out_Sample_11_101819_4_8_tri_tester1 <- trans_a_b
        out_Sample_11_101819_4_8_tri_tester1$diagonal <- paste("c", out_Sample_11_101819_4_8_tri_tester1$chrom1, "c", out_Sample_11_101819_4_8_tri_tester1$chrom2, sep ='_')
        out_Sample_11_101819_4_8_tri_tester12 <- merge(out_Sample_11_101819_4_8_tri_tester1, Sample_11_101819_ALL_expected, by="diagonal")
        out_Sample_11_101819_4_8_tri_tester12$obs_vs_exp <- out_Sample_11_101819_4_8_tri_tester12$count/out_Sample_11_101819_4_8_tri_tester12$count.avg
        abc_start1 <- data.frame(table(subset(out_Sample_11_101819_4_8_tri_tester12, obs_vs_exp > min_oe)$start1))
        abc_start2 <- data.frame(table(subset(out_Sample_11_101819_4_8_tri_tester12, obs_vs_exp > min_oe)$start2))
        dataset1[i,1] <- out_Sample_11_101819_4_8_tri_tester12[1,1]
        dataset1[i,2] <- ineq(abc_start1$Freq, parameter = NULL, type = c("Gini"), na.rm = TRUE)
        dataset1[i,3] <- ineq(abc_start2$Freq, parameter = NULL, type = c("Gini"), na.rm = TRUE)
        dataset1[i,4] <- mean(tail(sort(out_Sample_11_101819_4_8_tri_tester12$obs_vs_exp),10))
        dataset1[i,5] <- ineq(subset(out_Sample_11_101819_4_8_tri_tester12, obs_vs_exp > xx)$obs_vs_exp, parameter = NULL, type = c("Gini"), na.rm = TRUE)
        dataset1[i,6] <- nrow(subset(out_Sample_11_101819_4_8_tri_tester12, obs_vs_exp > sig_oe))/nrow(subset(out_Sample_11_101819_4_8_tri_tester12, obs_vs_exp > 0))
    }
    dataset1 <- data.frame(dataset1)
    dataset1$gini_start1 <- as.numeric(as.character(dataset1$gini_start1))
    dataset1$gini_start2 <- as.numeric(as.character(dataset1$gini_start2))
    dataset1$max_oe <- as.numeric(as.character(dataset1$max_oe))
    dataset1$gini_all <- as.numeric(as.character(dataset1$gini_all))
    dataset1$frac_sig_oe <- as.numeric(as.character(dataset1$frac_sig_oe))
    dataset1$combo <- dataset1$gini_start1*dataset1$gini_start2* dataset1$max_oe*dataset1$gini_all*dataset1$frac_sig_oe
    return(dataset1)
}