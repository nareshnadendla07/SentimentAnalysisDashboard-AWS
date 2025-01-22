import re
import string
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer

# Download stopwords if not already present
import nltk
nltk.download('stopwords')
nltk.download('punkt')

# Load stopwords
STOPWORDS = set(stopwords.words('english'))

def clean_text(text):
    """
    Cleans the input text by removing special characters, URLs, and extra spaces.
    """
    # Remove URLs
    text = re.sub(r"http\S+|www\S+|https\S+", '', text, flags=re.MULTILINE)
    # Remove HTML tags
    text = re.sub(r'<.*?>', '', text)
    # Remove special characters and digits
    text = re.sub(r"[^a-zA-Z\s]", '', text)
    # Remove multiple spaces
    text = re.sub(r'\s+', ' ', text).strip()
    return text

def remove_stopwords(text):
    """
    Removes stopwords from the input text.
    """
    words = word_tokenize(text)
    filtered_words = [word for word in words if word.lower() not in STOPWORDS]
    return ' '.join(filtered_words)

def preprocess_text(text):
    """
    Performs all preprocessing steps: cleaning, lowercasing, and stopword removal.
    """
    text = clean_text(text)
    text = text.lower()
    text = remove_stopwords(text)
    return text

def vectorize_text(texts, method="tfidf"):
    """
    Vectorizes the input texts using TF-IDF or Count Vectorization.
    Args:
        texts (list): List of preprocessed text.
        method (str): Vectorization method - "tfidf" or "count".
    Returns:
        Vectorized representation of texts.
    """
    if method == "tfidf":
        vectorizer = TfidfVectorizer()
    elif method == "count":
        vectorizer = CountVectorizer()
    else:
        raise ValueError("Invalid method. Choose 'tfidf' or 'count'.")
    
    vectors = vectorizer.fit_transform(texts)
    return vectors, vectorizer

if __name__ == "__main__":
    # Example usage
    example_texts = [
        "I love this product! It's amazing.",
        "This is a terrible experience. I hate it.",
        "Check out my website at https://example.com."
    ]
    
    # Preprocess each text
    preprocessed_texts = [preprocess_text(text) for text in example_texts]
    print("Preprocessed Texts:")
    print(preprocessed_texts)

    # Vectorize the texts
    vectors, vectorizer = vectorize_text(preprocessed_texts, method="tfidf")
    print("\nTF-IDF Vectors:")
    print(vectors.toarray())

    # Print feature names
    print("\nFeature Names:")
    print(vectorizer.get_feature_names_out())
