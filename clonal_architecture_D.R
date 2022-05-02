wd <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(wd)


library(tapestri.tools)
library(patchwork)
library(viridis)
library(ggsci)
library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

clone_size_D <- read_csv("clone_size/clone_size_D.csv")
clone_size_D$width <- sqrt(clone_size_D$n) / 10

col <- ggsci::pal_npg()(10)[1:9]



#svg("plots/clones/clones_D.svg", height = 4.81, width = 7.19)
grViz("
  digraph boxes_and_circles {

  # a 'graph' statement
  #graph [overlap = true, fontsize = 100]
  
  ##Root
  node [shape = plaintext]
  Root
  
  node [shape = point, fixedsize = true]
  
  IDH1_R132H [width = .447, color = '#E64B35FF']
  DNMT3A_R882C  [width = 1.56, color = '#4DBBD5FF']
  NPM1c_PM160345 [width = 4.15, color = '#00A087FF']
  GATA2_A372V [width = 1.95, color = '#3C5488FF']
  TET2_C1709R [width = 2.35, color = '#F39B7FFF']
  
  IDH2_R140Q [width = .374, color = '#8491B4FF']
  NPM1c_PM160053 [width = 2.53, color = '#91D1C2FF']
  TET2_H1778R [width = 1.04, color = '#DC0000FF']
  FLT3_ITD [width = .86, color = '#7E6148FF']
  
  ####Plot
  IDH1_R132H -> DNMT3A_R882C;
  Root -> IDH1_R132H;
  NPM1c_PM160345 -> GATA2_A372V;
  NPM1c_PM160345 -> TET2_C1709R;
  DNMT3A_R882C -> NPM1c_PM160345;
  
  IDH2_R140Q -> TET2_H1778R;
  TET2_H1778R -> NPM1c_PM160053;
  NPM1c_PM160053 -> FLT3_ITD;
  Root -> IDH2_R140Q;
  
}") -> p

p %>%
  DiagrammeRsvg::export_svg() %>% 
  charToRaw() %>% 
  rsvg_svg("plots/clones/clones_D.svg")
