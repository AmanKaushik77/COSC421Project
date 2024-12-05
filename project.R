library(igraph)

data <- read.csv("edges.csv", stringsAsFactors = FALSE)

colnames(data) <- c("Disease", "Symptom")


bipartite_graph <- graph_from_data_frame(data, directed = FALSE)


V(bipartite_graph)$type <- ifelse(V(bipartite_graph)$name %in% data$Symptom, 1, 0)


V(bipartite_graph)$color <- ifelse(V(bipartite_graph)$type == 1, "blue", "red")  
V(bipartite_graph)$size <- 5  
V(bipartite_graph)$label.color <- "black"
V(bipartite_graph)$label.cex <- 0.7

layout <- layout_with_fr(bipartite_graph, niter = 10000, grid = "nogrid")

plot(
  bipartite_graph,
  layout = layout_with_kk(bipartite_graph),
  vertex.label = V(bipartite_graph)$name,
  vertex.color = V(bipartite_graph)$color,
  vertex.size = V(bipartite_graph)$size,
  vertex.label.cex = V(bipartite_graph)$label.cex,
  main = "Bipartite Graph: Diseases and Symptoms"
)


legend(
  "topleft",
  legend = c("Disease", "Symptom"),
  col = c("red", "blue"),
  pch = 21,
  pt.cex = 1.5,
  bty = "n"
)


V(bipartite_graph)$degree <- degree(bipartite_graph, mode = "all")


V(bipartite_graph)$betweenness <- betweenness(bipartite_graph, directed = FALSE)

clustering_coeff_diseases <- transitivity(bipartite.projection(bipartite_graph)$proj1, type = "local")
clustering_coeff_symptoms <- transitivity(bipartite.projection(bipartite_graph)$proj2, type = "local")

V(bipartite_graph)$clustering <- ifelse(
  V(bipartite_graph)$type == 0,
  clustering_coeff_diseases[match(V(bipartite_graph)$name, names(clustering_coeff_diseases))],
  clustering_coeff_symptoms[match(V(bipartite_graph)$name, names(clustering_coeff_symptoms))]
)

V(bipartite_graph)$pagerank <- page_rank(bipartite_graph)$vector

cat("\nTop Diseases by Degree Centrality:\n")
diseases <- V(bipartite_graph)$name[V(bipartite_graph)$type == 0]
disease_degree <- V(bipartite_graph)$degree[V(bipartite_graph)$type == 0]
print(sort(setNames(disease_degree, diseases), decreasing = TRUE))

cat("\nTop Symptoms by Degree Centrality:\n")
symptoms <- V(bipartite_graph)$name[V(bipartite_graph)$type == 1]
symptom_degree <- V(bipartite_graph)$degree[V(bipartite_graph)$type == 1]
print(sort(setNames(symptom_degree, symptoms), decreasing = TRUE))

cat("\nTop Diseases by PageRank:\n")
disease_pagerank <- V(bipartite_graph)$pagerank[V(bipartite_graph)$type == 0]
print(sort(setNames(disease_pagerank, diseases), decreasing = TRUE))

cat("\nTop Symptoms by PageRank:\n")
symptom_pagerank <- V(bipartite_graph)$pagerank[V(bipartite_graph)$type == 1]
print(sort(setNames(symptom_pagerank, symptoms), decreasing = TRUE))

cat("\nTop Diseases by Clustering Coefficient:\n")
disease_clustering <- V(bipartite_graph)$clustering[V(bipartite_graph)$type == 0]
print(sort(setNames(disease_clustering, diseases), decreasing = TRUE, na.last = TRUE))

cat("\nTop Symptoms by Clustering Coefficient:\n")
symptom_clustering <- V(bipartite_graph)$clustering[V(bipartite_graph)$type == 1]
print(sort(setNames(symptom_clustering, symptoms), decreasing = TRUE, na.last = TRUE))

disease_projection <- bipartite.projection(bipartite_graph)$proj1

communities <- cluster_louvain(disease_projection)

V(disease_projection)$community <- membership(communities)

plot(
  communities,
  disease_projection,
  vertex.label = V(disease_projection)$name,
  vertex.color = rainbow(max(V(disease_projection)$community))[V(disease_projection)$community],
  vertex.size = 5,
  main = "Disease Communities"
)

legend(
  "topleft",
  legend = paste("Community", 1:max(V(disease_projection)$community)),
  col = rainbow(max(V(disease_projection)$community)),
  pch = 21,
  pt.cex = 1.5,
  bty = "n"
)

results <- data.frame(
  Node = V(bipartite_graph)$name,
  Type = ifelse(V(bipartite_graph)$type == 1, "Symptom", "Disease"),
  Degree = V(bipartite_graph)$degree,
  Betweenness = V(bipartite_graph)$betweenness,
  PageRank = V(bipartite_graph)$pagerank,
  ClusteringCoefficient = V(bipartite_graph)$clustering
)


