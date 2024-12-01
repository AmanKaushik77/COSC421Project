# COSC421Project

**Cosc 421 Project Proposal**

Symptoms: a Network Analysis of Symptoms that Lead Neurological Diagnoses Astray

**Abstract**

The importance of accurate medical diagnoses can not be overstated. Medical professionals face the challenge of distinguishing and identifying diseases that share conflicting symptoms and whose accurate and timely diagnosis has a defining impact on the treatment and outcome for the patient. Neurological disorders are “complicated and complex” to diagnose as “\[m\]any of the same symptoms happen in different combinations among the different disorders” and “don't have definitive causes, markers, or tests” (1). Rural communities, such as Canadian Indigenous communities, often have limited access to specialized healthcare professionals and are therefore likely to go longer without a diagnosis and treatment plan to expedite their recovery or receive support in their condition.

We plan to represent neurological diseases as a bipartite graph of symptoms and diseases. This can be adapted to aid in accurate diagnoses, trace misleading symptoms, and identify diseases that are likely to be confounded. A more rigorous Bayesian bipartite network offering the additional context of the probability of a disease given a set of symptoms displayed,personal, and environmental factors may be possible - contingent on data availability.

**Problem Statement:**

The problem we are tackling involves the challenge of diagnosing neurological disorders where symptoms are often misleading and lead to misdiagnoses. By constructing a bipartite network of symptoms and disease stages, we aim to identify the most misleading symptoms where confusion is most likely to arise. This will help improve diagnostic accuracy and outcomes.

**Research Questions:**

- Which symptoms are the most common sources of diagnostic confusion across neurological diseases?  

- Can the network reveal clusters of diseases that are frequently confounded and contain symptomatic overlap?

**Data Collection:**

We plan to use publicly available datasets from Kaggle that focus on neurological disorders, symptoms, and possibly patient demographics.

**Node and Edge Definitions:**

Node(s): Will represent diseases and symptoms.

Edges: Will represent the connection between a symptom and a disease.

**Desired Metrics:**

- Degree centrality - This will help identify which symptoms (or disease stages) have the most connections, indicating their presence or how common they are across the network  

- Betweenness centrality - This will measure how often a symptom or stage acts as a bridge between others in the network, showing its role in the flow of information or progression of disease.  

- Clustering coefficient - This metric will assess how tightly symptoms or disease stages cluster together, indicating the likelihood that a particular set of symptoms co-occurs within specific disease stages. Can be applied onto 1-mode projections of diseases as well as symptoms  

- PageRank - By applying this, you can identify symptoms or stages that are not only well-connected but also connected to other important nodes. This will give a view of symptom importance, throughout the network  

- Community detection - useful in identifying groups of diseases to understand their relationship to one another; i.e. one disease leads to the development of another, certain diseases that always go hand-in-hand, diseases that can be treated together / the same way, etc.

**Analysis Plan:**

1. Construct the bipartite network in R  

2. Calculate centrality measures for both symptoms and disease stages to identify the most critical nodes  

3. Perform community detection to see if there are groups of diseases with similar symptoms  

4. Visualize the network with node attributes like symptom type and disease severity  

5. A Bayesian network will be used to predict the probability of a disease given a set of symptoms

**Sources:**

<https://www.urmc.rochester.edu/encyclopedia/content.aspx?contenttypeid=85&contentid=P00811#:~:text=Evaluating%20and%20diagnosing%20damage%20to,make%20a%20diagnosis%20even%20harder>.
