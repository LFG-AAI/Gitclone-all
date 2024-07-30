#!/bin/bash

# Menampilkan intro ASCII
echo "****************************************************"
echo "*   JANGAN LUPA SUBS TELEGRAM :                   *"
echo "*   @allabout_internet & @LAPAK_DIGITAL            *"
echo "****************************************************"
echo ""

# Meminta input nama pengguna atau organisasi GitHub
read -p "Enter GitHub Username or Organization: " USER_OR_ORG

# Memeriksa apakah input tidak kosong
if [ -z "$USER_OR_ORG" ]; then
    echo "Error: You must enter a GitHub Username or Organization."
    exit 1
fi

# Mendapatkan direktori saat ini di mana skrip dijalankan
DEST_DIR="$(pwd)/repositories"

# Membuat direktori jika belum ada
mkdir -p "$DEST_DIR"
cd "$DEST_DIR"

# Mengambil daftar repositori dan meng-clone setiap repositori
curl -s "https://api.github.com/users/$USER_OR_ORG/repos?per_page=100" | \
grep -oP '"clone_url": "\K(.*)(?=")' | \
while read -r repo; do
    echo "Cloning $repo..."
    git clone "$repo"
done

echo "Cloning complete."
