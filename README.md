# Predictive-Text
Word Predictor using n-gram likelihood estimators

## MyWord - the simple predictor 

The prediction algorithm is based on Katz Back-Off language model using 1, 2, 3, 4 and 5-grams

The bi-gram Maximum Likelihood estimate are calculated using the 1-gram and 2-gram counts, discounted for unobserved bigrams

The 1-gram's unobserved in the bi-gram prediction is allocated a portion of the discount depending on their 1-gram count

The same logic is used to build the 3-grams observed and unobserved, using the 2-grams as a source for the unobserved

Expanding to 4 grams and 5 grams probabilities effectively includes the back-off logic in the final observations

The prediction solution is built in a Shiny application with two sricpts

* server.R

* ui.R

## N-gram training

The n-gram training is done using 3 source files.  The R training scripts was run on a 16 meg memory laptop.  The solution to works in increments to stay within the memory limitation, preparing the nGram files in three major steps:

1. Read and clean-up

2. Creating n-grams

3. Merging n-grams

Three text sources:

* Clean_en_US.blogs.txt (899 289 lines)

* Clean_en_US.news.txt (1 010 243 lines)

* Clean_en_US.twitter.txt (2 360 149 lines)

## Read and clean up
 The scripts reads the 3 source files and clean the text write out to clean three clean files.

Scripts:

* A_CleanSourceFiles.R

* badwordsfixes.R

* readingAndWritingFiles.R 

Cleanup entails:

1. Remove punctuation marks, special characters and digits

2. Convert all uppercase charaters to lower case

3. Remove any non-alphabetical characters

4. Remove all bits of words

5. Replace multiple spaces with single spaces

## Create n-grams

Creates a set of five n-grams for each source files.

single word 1-gram, 2-gram, 3-gram, 4-gram, 5-gram

Scripts:

* B_Create_n_grams

* readingAndWritingFiles.R 

* nGramStringManipulation.R

## Merge n-grams

Merge the n-grams from the 3 source files into 5 files. Each line in the n-gram files countatina a column of n words with a second column listing their frequency. 

oneGrams.csv, twoGrams.csv, threeGrams.csv, fourGrams.csv, fiveGrams.csv

Scripts:

* C_MergeNgrams.R

* mergeFunctions.R
