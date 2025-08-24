import hashlib

# Function to compute hash of a file
def hash_file_sha1(filename, chunk_size=8192):
    """Return SHA-1 hex digest of a file, reading in chunks."""
    h = hashlib.sha1()
    with open(filename, 'rb') as f:   # rb = read binary
        while True:
            chunk = f.read(chunk_size)  # read 8KB at a time
            if not chunk:               # stop when nothing left
                break
            h.update(chunk)             # update hash with chunk
    return h.hexdigest()

# Function to compare two PDFs
def pdfs_identical_sha1(file1, file2):
    h1 = hash_file_sha1(file1)   # get hash of first file
    h2 = hash_file_sha1(file2)   # get hash of second file
    return h1 == h2              # True if same, False if different

# Example usage
file1 = r"C:/Users/HP/Desktop/Desktop/SureTrust/Python/Assignment/identical_PDF/file 1.pdf"
file2 = r"C:/Users/HP/Desktop/Desktop/SureTrust/Python/Assignment/identical_PDF/file 2.pdf"

if pdfs_identical_sha1(file1, file2):
    print("Both PDF files are IDENTICAL.")
else:
    print("PDF files are DIFFERENT.")
