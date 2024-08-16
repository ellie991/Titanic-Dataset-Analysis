# Titanic-Dataset-Analysis
Big Data Analysis on Titanic Dataset

Per analizzare il dataset sui passeggeri del Titanic, contenente come variabili ID passeggero, sopravvivenza (0=no, 1=si), classe d’imbarco (1, 2, 3), nome, sesso, età, biglietto, tariffa, cabina, imbarco; ho formulato tre ipotesi della sopravvivenza in base alla classe, all’età e al sesso, organizzando le osservazioni in 3 cluster.
IPOTESI 1: SOPRAVVIVENZA IN BASE ALLA CLASSE (1, 2, 3)
Dopo aver importato i dataset train e test csv, ho creato un grafico a barre con barplot() per vedere graficamente la dimensione delle tre classi di viaggio in base al numero di passeggeri e come si può notare la terza classe è quella con il più alto numero di passeggeri, seguita dalla prima e dalla seconda.
Ho poi costruito il modello ad albero con la funzione rpart() utilizzando come variabile risposta la variabile Survived in base alla variabile predittiva Pclass, ossia la classe di viaggio. Con la funzione plot ho visualizzato l’albero, comprimendolo per adattarlo meglio e inserendo le etichette ai nodi. L’albero interpreta come 0 la previsione di non sopravvivenza e 1 invece la sopravvivenza. Dal nodo iniziale Pclass>=2.5 indica quindi la terza classe che nel ramo di sinistra è prevista come non sopravvissuta, con 379 non sopravvissuti e 119 sopravvissuti. Nella ramificazione di destra si ha la Pclass>=1.5 ossia la seconda classe e tecnicamente anche la prima, che è prevista come sopravvissuta.
Con rpart.plot() ho visualizzato lo stesso albero con i dati più ordinati comprese le percentuali nei nodi indicanti la proporzione di osservazioni del dataset che ricadono in quel nodo. Per esempio il nodo con probabilità di sopravvivenza stimata (1), 0.63 indica che il 63% delle osservazioni di quel nodo ha avuto una sopravvivenza stimata (1) secondo le condizioni usate per la divisione dell’albero; mentre 24% indica la proporzione di osservazioni rispetto al totale, cioè la percentuale di osservazioni nel dataset che soddisfano le condizioni di quel nodo.
In generale, si può dire che l'albero di decisione suggerisce che la classe di viaggio è un fattore significativo per predire la sopravvivenza, infatti i passeggeri di classe superiore (1 e 2) tendono ad avere maggiori probabilità di sopravvivenza rispetto ai passeggeri di classe inferiore (3) probabilmente perché hanno avuto la precedenza alle scialuppe.
Infine ho calcolato le previsioni del modello sull’insieme dei dati del train set, con la funzione predict() e ne ho valutato l’accuratezza, che risulta essere pari a 0.6790123, 68%.
IPOTESI 2: SOPRAVVIVENZA IN BASE ALL’ETÀ.
Per prima cosa ho fatto un clustering delle età basandomi sull’algoritmo di kmeans, quindi dopo aver rimosso le righe con dati mancanti sull'età, ho selezionato la variabile "Age" come variabile di interesse. Le età selezionate le ho poi standardizzate utilizzando la funzione scale(), così facendo vengono sottratti la media e divisi per la deviazione standard, in modo che tutte le età abbiano una distribuzione con media zero e deviazione standard uno.
Ho poi applicato l'algoritmo K-means per eseguire il clustering delle età standardizzate con kmeans(), scegliendo tre cluster in cui i punti dati vengono assegnati in base alla loro distanza dai centroidi (i punti medi dei cluster); la funzione k-means() cerca di minimizzare la somma dei quadrati delle distanze dei punti all'interno di ciascun cluster. Ho poi stampato i centroidi dei cluster con la funzione centroids().
Poi ho assegnato le etichette di cluster ai dati di addestramento in base alla clusterizzazione ottenuta e ho aggiunto una colonna chiamata "Cluster" al dataset train_data contenente le etichette di cluster assegnate.
Ho poi calcolato il valore medio e la deviazione standard delle età nel dataset originale con mean() e sd(); e ho calcolato e stampato i valori di età corrispondenti agli intervalli visualizzati sull'asse x, basati sulla media e deviazione standard delle età, nel mio caso
Età corrispondenti all'intervallo da -2 a -1: 0.646123 (6 mesi) Età corrispondenti all'intervallo da -1 a 0.5: 15.17262 (15 anni) Età corrispondenti all'intervallo da 0.5 a 3: 36.96237 (37 anni)
13
Poi ho creato un grafico di dispersione delle età standardizzate, dove i punti sono colorati in base alle etichette di cluster assegnate. Nel grafico si può notare all’asse x che le osservazioni sono state standardizzate per avere una media di 0 e una deviazione standard di 1; quindi i valori sull'asse x non rappresentano le età effettive dei passeggeri, ma sono dei valori relativi che indicano quanto l'età di ciascun passeggero si discosta dalla media. Si possono interpretare quindi i punti nel grafico in relazione ai cluster a cui appartengono e osservare come si distribuiscono le età rispetto alla media.
Nell’asse delle y invece ci sono le età in fasce: da -2 a -1 c’è un cluster con le età corrispondenti alla media di 0.646123, da -1 a 0.5 i passeggeri in età media pari 15.17262 e infine nella fascia più alta dell’età da 0.5 a 3 i passeggeri adulti, con età media 36.96237.
Questo plot permette di identificare i gruppi di passeggeri con caratteristiche simili in base all'età, ed è possibile notare in questo caso, che il cluster più in basso include i passeggeri più giovani, mentre il cluster più in alto include i passeggeri più anziani.
Ho inoltre calcolato il conteggio delle osservazioni per ogni cluster con table(), per aggiungerlo con una legenda allo scatter plot, viene quindi indica il numero di osservazioni per ogni cluster nel grafico con paste() e legend() permettendo di intuire meglio il plot.
Oltre allo scatter plot ho voluto anche rappresentare il box plot delle età per ogni cluster, che fornisce allo stesso modo informazioni sulla distribuzione delle età all'interno di ciascun cluster, stampandole con un ciclo for che itera attraverso gli elementi di boxplot_stats (lista che contiene le statistiche del boxplot per ogni cluster), dove i assume valori corrispondenti al numero dei cluster. Ad ogni iterazione, il codice all'interno del ciclo viene eseguito per ogni cluster.
Ottenendo così: Cluster 1 Mediana: 50 Primo quartile: 47 Terzo quartile: 58 Valori minimi: 43 Valori massimi: 74
Cluster 2 Mediana: 32 Primo quartile: 28 Terzo quartile: 36 Valori minimi: 24.5 Valori massimi: 42
Cluster 3 Mediana: 18 Primo quartile: 13 Terzo quartile: 22 Valori minimi: 0.42 Valori massimi: 24
Nel primo cluster il cerchietto bianco sopra il baffo indica la presenza di un valore anomalo (outlier) a un'età pari a 80. La linea all'interno di ogni box rappresenta la mediana delle età per il cluster corrispondente, cioè il valore centrale della distribuzione. I limiti inferiori e superiori di ogni box rappresentano il primo quartile e il terzo quartile delle età per il cluster, l'intervallo tra questi due limiti è l’intervallo interquartile e rappresenta il 50% centrale dei dati. I "baffi" sopra e sotto il box si estendono fino ai punti che si trovano entro 1,5 volte l’intervallo interquartile sopra e sotto il box. Questi punti sono considerati valori "non outlier" e possono rappresentare una parte significativa della distribuzione. Se i baffi sono molto lunghi o ci sono molti punti oltre i baffi, potrebbe essere presente una maggiore variabilità o presenza di outlier nella distribuzione delle età del cluster come nel mio caso del cluster 1 che ha anche il cerchietto dell’outlier.
Si possono notare valori simili restituiti dallo scatter e dal box plot.
14

CLUSTERING ETÀ&TARIFFA
Ho voluto fare anche un clustering che considerasse età e tariffa. Prima di eseguire l'analisi ho di nuovo rimosso le righe che presentano dati mancanti per l'età, per assicurarmi che solo i dati completi venissero utilizzati nell'analisi, usando la funzione !is.na(). Poi ho selezionato le variabili di mio interesse, Age (età) e Fare (tariffa) dal dataset e le ho standardizzate in modo che abbiano una scala comparabile, perché potrebbero avere unità di misura diverse.
Come nel cluster precedente ho applicato l'algoritmo k-means per suddividere i dati 3 cluster in cui i punti dati vengono assegnati a cluster in base alla loro distanza dai centroidi con la funzione k- means() e ho assegnato di nuovo a ciascuna osservazione una etichetta di cluster.
Infine ho visualizzato il grafico a dispersione dei dati di addestramento in base all'età e alla tariffa, dove i punti sono colorati in base all'etichetta di cluster; qui l'asse x rappresenta i valori standardizzati dell'età, dove i valori negativi rappresentano un'età inferiore alla media e i valori positivi rappresentano un'età superiore alla media. Anche qui, poiché la scala è stata standardizzata, non è possibile interpretare i valori specifici sull'asse x come età effettive, quindi l'asse x rappresenta solo la posizione relativa dei punti dati in base all'età standardizzata mentre l'asse y rappresenta la posizione relativa dei punti dati sempre in base alla tariffa standardizzata. Osservando la posizione dei centroidi dei cluster (asterischi), si può notare che i cluster sembrano essere definiti principalmente in base alla tariffa dei passeggeri. Ad esempio, nel mio caso, il cluster nero sembra essere caratterizzato da passeggeri con tariffe relativamente basse, mentre il cluster rosso sembra comprendere passeggeri con tariffe più elevate. Il cluster verde sembra rappresentare un gruppo intermedio di passeggeri con tariffe moderate.
La posizione dei centroidi dei cluster è influenzata sia dall'età che dalla tariffa, quindi si può intuire che anche l'età dei passeggeri all'interno di ciascun cluster può variare. Questo risultato potrebbe rendere possibile ipotizzare che i passeggeri con tariffe più elevate (cluster rosso) possano rappresentare una classe più abbiente, mentre i passeggeri con tariffe più basse (cluster nero) potrebbero rappresentare una classe meno abbiente.
Infine ho stampato una tabella che mostra il conteggio dei passeggeri assegnati a ciascun cluster: 330 per il 1, 136 per il 2 e 248 per il 3.
Ho poi usato la funzione aggregate(), con cui sono state calcolate le medie delle variabili Age e "Fare" per ogni cluster, fornendo un’idea delle caratteristiche distintive dei cluster in termini di età media e tariffa media, si può infatti notare che ci sono cluster con passeggeri più giovani (cluster 1, età media 23 anni > tariffa 25,50) e con tariffe più basse rispetto ad altri cluster.
Per verificare la validità del clustering, ho utilizzato la silhouette come misura; questa valuta quanto bene ogni oggetto nel dataset si adatta al proprio cluster rispetto agli altri cluster. È un indicatore della coesione all'interno dei cluster e della separazione tra i cluster e assume valori compresi tra - 1 e 1. Un valore alto indica che l'oggetto è stato assegnato correttamente al proprio cluster, mentre un valore basso indica che l'oggetto potrebbe essere stato assegnato erroneamente. Quindi dopo aver importato la libreria(cluster) ho calcolato la matrice delle distanze con la funzione dist() che rappresenterà appunto le distanze tra le osservazioni nel dataset in base alle variabili selezionate, fornendo una misura di quanto le osservazioni siano lontane o vicine tra loro. Con la funzione silhouette() ho calcolato il coefficiente della silhouette per ogni osservazione nel dataset, prendendo in input le etichette di cluster e la matrice delle distanze. Poi ho calcolato il coefficiente di silhouette medio prendendo la media dei valori di sil_width nella matrice silhouette_scores con la funzione mean(), nel mio caso ho ottenuto il suo valore stampato pari a 0.4598045, ed essendo una misura che varia tra -1 e 1, 0.45 indica un buon livello di accuratezza.
Ho poi calcolato i punteggi medi di silhouette per ogni cluster utilizzando la funzione tapply() calcolando la media dei valori di sil_width per ogni cluster separato in base alle etichette di cluster, questi punteggi danno un'idea di quale cluster ha una migliore coesione interna e una migliore separazione dagli altri cluster.
Poi ho riordinato i cluster in base al punteggio di silhouette medio, in ordine crescente con sort(). Infine, ho potuto creare il grafico a barre dei coefficienti di Silhouette per ogni cluster, sull'asse y, mentre gli identificatori dei cluster sono visualizzati sull'asse x, fornendo una rappresentazione visiva
15

della qualità del clustering per ciascun cluster, in cui ogni barra rappresenta il punteggio di silhouette per il rispettivo cluster.
Il plot infatti nel mio caso mostra sull'asse orizzontale tre barre corrispondenti ai cluster 2, 3 e 1. Il cluster 2 ha il coefficiente più alto, che raggiunge 0.6. Questo indica che gli oggetti all'interno del di questo cluster si adattano molto bene al proprio cluster e sono ben separati dagli altri cluster. Il cluster 3 segue con un coefficiente di 0.5, mentre il cluster 1 ha il coefficiente più basso di circa 0.4. Risulta quindi che il cluster 2 quindi è quello più coeso e separato, mentre il cluster 1 potrebbe presentare una maggiore sovrapposizione con gli altri cluster, ma dato che tutti i coefficienti sono positivi, significa che in generale tutti gli oggetti sono stati assegnati correttamente ai loro cluster.
PREDIZIONE
Dopo aver rimosso le righe del dataset di addestramento che hanno valori mancanti nell'età con !is.na() ho creato il modello di regressione logistica per fare previsioni sulla sopravvivenza utilizzando il train_data, usando la variabile Survived come variabile di risposta e Age come variabile predittiva, con la funzione glm().
Per predire la sopravvivenza ho usato la funzione predict() restituendo le previsioni vengono restituite come probabilità di sopravvivenza e ho stampato le prime righe del dataset di addestramento:
>head(train_predictions)
123457 0.4260661 0.3838272 0.4153788 0.3916351 0.3916351 0.3432713
Nel mio caso l’età è stata divisa in 7 classi, ognuna con la sua probabilità stimata di sopravvivenza. Sono stati infatti definiti gli intervalli di età con un vettore di fattori che divide l'età in intervalli specificati [0,10], (10,20], (20,30], (30,40], (40,50], (50,60], (60,Inf].
Ho calcolato anche la media delle probabilità di sopravvivenza per ogni intervallo di età, con la funzione tapply().
Poi ho creato il grafico a barre raggruppate che mostra le medie delle probabilità di sopravvivenza per ogni intervallo di età nel dataset train. Dal plot si può notare come la probabilità diminuisce all’aumentare dell’età. Ho aggiunto anche una linea tratteggiata rossa di riferimento per la soglia di sopravvivenza che rappresenta la soglia di probabilità di sopravvivenza pari a 0.5.
Poi ho effettuato una nuova predizione utilizzando il modello di regressione logistica sul dataset di addestramento, ho creato delle classi di previsione basate sul valore di probabilità: se la probabilità è maggiore o uguale a 0.5, viene assegnata la classe 1 (sopravvissuto), altrimenti viene assegnata la classe 0 (non sopravvissuto).
Poi ho calcolato la matrice di confusione che mostra il numero di previsioni corrette e erronee per ciascuna classe e l’ho stampata:
>predicted_classes 0 1
0 424 290
(424 predetti correttamente non soprav.; 290 predetti correttamente soprav.)
Per finire ho calcolato l'accuratezza del modello, dividendo la somma dei valori diagonali della matrice di confusione per la somma di tutti gli elementi della matrice, pari a 0.593837535014006, 59,38% di casi correttamente predetti (sia sopravvissuti che non sopravvissuti) rispetto al totale dei casi nel dataset di addestramento.
IPOTESI 3: SOPRAVVIVENZA IN BASE AL SESSO
Dopo aver rimosso le righe con i dati mancanti sull’età e il sesso dei passeggeri ho selezionato le due variabili di interesse Age e Sex, codificando quest’ultima come variabile numerica per confrontarla senza errori con Age, assegnando maschio=0 e femmina=1.
Come nei clustering precedenti ho sempre scelto tre cluster, usando la funzione kmeans() sul train set, considerando solo le colonne con le variabili di mio interesse; poi ho calcolato e visualizzato i centroidi del cluster, assegnando le etichette e aggiungendole al dataset train_data.
16

Poi finalmente ho creato il plot a dispersione, con i colori dei cerchietti in base ai cluster: questo plot rappresenterà l'età sull'asse x (da 0 a 80 anni) e il sesso sull'asse y (0.0= M; 1.0=F), con i cerchi colorati in base alle etichette di cluster.
Nel mio caso, il plot ottenuto mostra una serie di cerchietti dei tre colori dei 3 cluster disposti in linea, all’altezza dell’asse y 0.0 (M) e 1.0 (F) e gli asterischi dei tre cluster alle altezze 0.42, 0.33, 0.31, come stampato nel comando precedente.
Il primo cluster sia per uomini che per donne mostra le osservazioni che arrivano sino ai 22 anni circa; stessa cosa il cluster seguente che dai 22 anni arriva fino a poco oltre i 40 anni, mentre il terzo cluster che sembra essere quello con più osservazioni arriva fino a circa 63 anni per le donne e a 80 per gli uomini (anche dal boxplot sull’età fatto nell’ipotesi precedente c’era un valore outlier all’altezza degli 80 anni). Dal grafico si può intuire quindi che la prevalenza di anziani oltre i 60 anni erano uomini.
PREDIZIONE
Infine ho fatto la predizione della sopravvivenza in base al sesso usando randomForest, quindi, dopo aver indicato la libreria, ho usato la funzione factor() per assicurarmi che la variabile Sex nel dataset di addestramento sia un fattore, un tipo di variabile categorica.
Poi ho rimosso le righe del dataset di addestramento che hanno dati mancanti o incongruenti per le variabili Sex e Survived, in modo che il dataset sia pulito e pronto per l'addestramento del modello, con complete.cases(). Poi ho convertito anche la variabile Survived nel dataset di addestramento in un fattore appunto. Survived sarà la variabile di risposta che indicherà se un passeggero è sopravvissuto o meno.
Poi ho creato il modello con randomForest(), indicando con la formula Survived ~ Sex che sto cercando di prevedere la variabile Survived in base alla variabile Sex. Data indica il dataset di addestramento e ntree=500 sono gli alberi da creare nel modello.
Poi ho convertito la variabile Sex nel dataset di test in un fattore, utilizzando gli stessi livelli di categoria presenti nel dataset di addestramento in modo tale che le categorie della variabile Sex siano coerenti tra il dataset di addestramento e quello di test.
Ho poi usato predict() sul modello rf per eseguire le predizioni sulla sopravvivenza, effettuandole sul dataset di test passando come parametro newdata.
Ho creato il grafico a dispersione che mostra la sopravvivenza in base al sesso nel dataset di addestramento con la funzione plot(), qui i punti del grafico sono colorati in base alle predizioni effettuate dal modello Random Forest sul dataset di test. Dal plot della random forest si può vedere l'asse x che rappresenta le due categorie 1=female e 0=male, sull'asse y le categorie della sopravvivenza 0=non sopravvissuto e 1=sopravvissuto, e le relative percentuali, che rappresentano la proporzione di sopravvivenza per ciascuna categoria riguardante il genere.
In questo caso, il grafico mostra che per la categoria female la percentuale di sopravvivenza è del 0.79, significa che il 79% delle donne nel dataset di addestramento è sopravvissuto contro lo 0.2 del genere male (il 20% è sopravvissuto).
Infine ho calcolato le predizioni sulla sopravvivenza sempre con il modello random forest sul dataset di addestramento stesso, calcolandone poi l’accuratezza con la funzione sum() confrontando le predizioni con le etichette di sopravvivenza effettive nel dataset di addestramento.
Infine ho stampato l’accuratezza del dataset di addestramento, pari a 0.780112044817927, 78%.














The analysis is based on the Titanic dataset, which has been loaded from GitHub. The dataset includes passenger information such as passenger ID, survival status, class of travel, name, sex, age, ticket number, fare, cabin, and embarkation port.

In this analysis, I explore three hypotheses regarding survival chances based on different passenger features. Specifically, the project investigates survival probabilities based on:

Passenger Class: Using decision trees to visualize survival likelihood across different classes.
Age: Applying clustering techniques to understand age distributions and their impact on survival.
Sex: Analyzing survival predictions based on gender using Random Forests.
The analysis involves data visualization, model building, and evaluation to uncover insights into the factors influencing survival on the Titanic.

This project analyzes the Titanic passenger dataset, which includes variables such as Passenger ID, survival (0=no, 1=yes), passenger class (1, 2, 3), name, sex, age, ticket, fare, cabin, and embarkation. We formulated three hypotheses regarding survival based on class, age, and sex, organizing observations into clusters. 

## ANALYSIS 1: Survival Based on Class (1, 2, 3)

After importing the training and test datasets, we created a bar plot to visually represent the distribution of passengers across the three classes. It was observed that the third class has the highest number of passengers, followed by the first and second classes.

We built a decision tree model using the `rpart()` function, predicting survival based on the `Pclass` variable. The decision tree, visualized with `plot()` and `rpart.plot()`, shows that passengers in higher classes (1 and 2) are more likely to survive compared to those in the lower class (3). The tree indicates that class is a significant factor in predicting survival, with higher-class passengers having greater survival probabilities, possibly due to having access to lifeboats. The model’s accuracy on the training set was 68%.

## ANALYSIS 2: Survival Based on Age

We performed age clustering using the K-means algorithm after removing rows with missing age data. Age was standardized, and K-means clustering with three clusters was applied. The scatter plot of standardized ages shows clusters of different age groups, with cluster 1 representing younger passengers, cluster 2 middle-aged passengers, and cluster 3 older passengers. A box plot further detailed age distribution within each cluster, highlighting significant outliers in the first cluster.

A second clustering considering both age and fare was done, revealing that clusters were primarily differentiated by fare, with clusters showing a range of fares and ages. The silhouette score, which measures clustering quality, was 0.46, indicating a good clustering fit.

## ANALYSIS 3: Survival Based on Sex

We clustered passengers based on sex and age. Sex was coded numerically (male=0, female=1) and K-means clustering with three clusters was applied. The scatter plot showed that older passengers were predominantly male, as indicated by a noticeable outlier age of 80 years.

For survival prediction based on sex, we used the Random Forest model. After preparing the dataset, the model predicted survival based on sex, showing a 79% survival rate for females and 20% for males. The accuracy of this model on the training set was 78%.

## Summary

- **Class-Based Survival**: Higher-class passengers have a higher survival probability. Accuracy of the decision tree model: 68%.
- **Age-Based Clustering**: Clustering by age revealed three distinct groups with different age distributions. Clustering based on age and fare showed clusters differentiated mainly by fare. Silhouette score: 0.46.
- **Sex-Based Survival**: Female passengers had a higher survival rate compared to males. Random Forest model accuracy: 78%.

This analysis highlights the impact of passenger class, age, and sex on survival chances on the Titanic.









GRAPHS
ANALYSIS 1: Survival Based on Class (1, 2, 3)

<img width="572" alt="Screenshot 2024-08-16 alle 13 00 18" src="https://github.com/user-attachments/assets/61a28525-7577-43c8-b976-83d6c6d27f90">
<img width="569" alt="Screenshot 2024-08-16 alle 13 00 38" src="https://github.com/user-attachments/assets/24b3b378-d64b-411f-977e-8e4388debf6e">

ANALYSIS 2: Survival Based on Age

<img width="481" alt="Screenshot 2024-08-16 alle 13 05 20" src="https://github.com/user-attachments/assets/a38675df-f34e-424f-9131-505104d685cb">
<img width="529" alt="Screenshot 2024-08-16 alle 13 06 16" src="https://github.com/user-attachments/assets/8513ddde-8c4d-4dc4-9187-2c7d28940d64">


ANALYSIS 3: Survival Based on Sex

<img width="551" alt="Screenshot 2024-08-16 alle 13 07 14" src="https://github.com/user-attachments/assets/330e19ba-3d46-416e-8ece-d38df20fa435">
<img width="525" alt="Screenshot 2024-08-16 alle 13 06 46" src="https://github.com/user-attachments/assets/cdf55257-4e22-4bdd-bd7b-e78fdfeeeee5">

