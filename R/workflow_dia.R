
#' Create Workflow Diagram Figure
#'
#' @return PDF of workflow diagram
#' @export workflow_dia
#'
#' @examples
#'
#' workflow_dia()
#'

workflow_dia <- function() {
  p <- DiagrameRsvg::export_svg(
    DiagrammeR::grViz(
      "digraph Fig1 {
    graph [fontsize = 8, nodesep=0.5]

    node [shape = box, style = filled, fillcolor = grey99, width = 1.2,fontname = Helvetica]
    Question; Methodology; Data; Analysis; Manuscript;

    node [shape = box, style = filled, fillcolor = grey90, width = 1.2,fontname = Helvetica]
    Description; Availability; Citation

    node [shape = box, style = filled, fillcolor = grey80, width = 1.2]
    'Binary Code'; 'Binary File'; Supplement

    node [shape = box, style = filled, fillcolor = grey70, width = 1.2]
    'Source Code'; 'Data File'; 'Public Repository';

    Question->Methodology->Data->Analysis
    Analysis->Manuscript
    Methodology->Description
    Methodology->Citation
    Methodology->Availability
    Manuscript->Supplement
    Data->'Data File'->'Public Repository'
    Analysis->'Binary Code'->Supplement
    Analysis->'Source Code'->'Public Repository'
    Data->'Binary File'->Supplement
  }",
      width = 1000,
      height = 750
    ))
  return(rsvg::rsvg_pdf(charToRaw(p)))
}
