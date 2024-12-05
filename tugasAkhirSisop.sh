#!/bin/bash

manipulasiHakAkses() {
    echo "Masukkan nama file (tanpa ekstensi):"
    read file
    file="${file}.sh"
    touch "$file" # Membuat file jika belum ada
    echo "File $file telah dibuat atau sudah ada."

    echo "Pilih operasi:"
    echo "1: Tambah hak akses"
    echo "2: Hapus hak akses"
    read operasi

    if [ "$operasi" -eq 1 ]; then
        echo "Hak akses apa yang ingin ditambahkan? (contoh: +x untuk execute):"
        read hak
        chmod "$hak" "$file"
        echo "Hak akses $hak telah ditambahkan ke $file"
    elif [ "$operasi" -eq 2 ]; then
        echo "Hak akses apa yang ingin dihapus? (contoh: -x untuk execute):"
        read hak
        chmod "$hak" "$file"
        echo "Hak akses $hak telah dihapus dari $file"
    else
        echo "Operasi tidak valid. Silakan coba lagi."
    fi
}

# Fungsi untuk membuka aplikasi
membukaAplikasi() {
    echo "Masukkan nama aplikasi yang ingin dibuka (contoh: firefox):"
    read aplikasi
    $aplikasi &
    echo "Aplikasi $aplikasi sedang dibuka..."
}

# Fungsi untuk kalkulator suhu
kalkulatorSuhu() {
    echo "Pilih satuan asal:"
    echo "1: Celsius (°C)"
    echo "2: Fahrenheit (°F)"
    echo "3: Kelvin (K)"
    echo "4: Reamur (°Re)"
    read asal

    echo "Masukkan nilai suhu:"
    read suhu

    echo "Pilih satuan tujuan:"
    echo "1: Celsius (°C)"
    echo "2: Fahrenheit (°F)"
    echo "3: Kelvin (K)"
    echo "4: Reamur (°Re)"
    read tujuan

    hasil=0

    if [ "$asal" -eq 1 ]; then
        # Dari Celsius
        case "$tujuan" in
            1) hasil=$suhu ;; # Celsius ke Celsius
            2) hasil=$(echo "scale=2; ($suhu * 9/5) + 32" | bc) ;; # Celsius ke Fahrenheit
            3) hasil=$(echo "scale=2; $suhu + 273.15" | bc) ;; # Celsius ke Kelvin
            4) hasil=$(echo "scale=2; $suhu * 4/5" | bc) ;; # Celsius ke Reamur
        esac
    elif [ "$asal" -eq 2 ]; then
        # Dari Fahrenheit
        case "$tujuan" in
            1) hasil=$(echo "scale=2; ($suhu - 32) * 5/9" | bc) ;; # Fahrenheit ke Celsius
            2) hasil=$suhu ;; # Fahrenheit ke Fahrenheit
            3) hasil=$(echo "scale=2; (($suhu - 32) * 5/9) + 273.15" | bc) ;; # Fahrenheit ke Kelvin
            4) hasil=$(echo "scale=2; ($suhu - 32) * 4/9" | bc) ;; # Fahrenheit ke Reamur
        esac
    elif [ "$asal" -eq 3 ]; then
        # Dari Kelvin
        case "$tujuan" in
            1) hasil=$(echo "scale=2; $suhu - 273.15" | bc) ;; # Kelvin ke Celsius
            2) hasil=$(echo "scale=2; (($suhu - 273.15) * 9/5) + 32" | bc) ;; # Kelvin ke Fahrenheit
            3) hasil=$suhu ;; # Kelvin ke Kelvin
            4) hasil=$(echo "scale=2; ($suhu - 273.15) * 4/5" | bc) ;; # Kelvin ke Reamur
        esac
    elif [ "$asal" -eq 4 ]; then
        # Dari Reamur
        case "$tujuan" in
            1) hasil=$(echo "scale=2; $suhu * 5/4" | bc) ;; # Reamur ke Celsius
            2) hasil=$(echo "scale=2; (($suhu * 9/4) + 32)" | bc) ;; # Reamur ke Fahrenheit
            3) hasil=$(echo "scale=2; ($suhu * 5/4) + 273.15" | bc) ;; # Reamur ke Kelvin
            4) hasil=$suhu ;; # Reamur ke Reamur
        esac
    else
        echo "Pilihan satuan asal tidak valid."
        return
    fi

    echo "Hasil konversi: $hasil"
}

# Fungsi untuk menghitung luas bangun datar dan volume bangun ruang
menghitungLuasVolume() {
    echo "Pilih jenis perhitungan:"
    echo "1: Luas Bangun Datar"
    echo "2: Volume Bangun Ruang"
    read jenis

    if [ "$jenis" -eq 1 ]; then
        echo "Pilih bangun datar:"
        echo "1: Persegi"
        echo "2: Lingkaran"
        echo "3: Segitiga"
        echo "4: Persegi Panjang"
        read bangun

        case "$bangun" in
            1) 
                echo "Masukkan sisi persegi:"
                read sisi
                luas=$((sisi * sisi))
                echo "Luas persegi adalah $luas"
                ;;
            2) 
                echo "Masukkan jari-jari lingkaran:"
                read jari
                luas=$(echo "scale=2; 3.14 * $jari * $jari" | bc)
                echo "Luas lingkaran adalah $luas"
                ;;
            3) 
                echo "Masukkan alas segitiga:"
                read alas
                echo "Masukkan tinggi segitiga:"
                read tinggi
                luas=$(echo "scale=2; 0.5 * $alas * $tinggi" | bc)
                echo "Luas segitiga adalah $luas"
                ;;
            4) 
                echo "Masukkan panjang persegi panjang:"
                read panjang
                echo "Masukkan lebar persegi panjang:"
                read lebar
                luas=$((panjang * lebar))
                echo "Luas persegi panjang adalah $luas"
                ;;
            *) 
                echo "Pilihan tidak valid untuk bangun datar."
                ;;
        esac

    elif [ "$jenis" -eq 2 ]; then
        echo "Pilih bangun ruang:"
        echo "1: Kubus"
        echo "2: Balok"
        echo "3: Bola"
        echo "4: Tabung"
        read bangun

        case "$bangun" in
            1) 
                echo "Masukkan panjang sisi kubus:"
                read sisi
                volume=$((sisi * sisi * sisi))
                echo "Volume kubus adalah $volume"
                ;;
            2) 
                echo "Masukkan panjang balok:"
                read panjang
                echo "Masukkan lebar balok:"
                read lebar
                echo "Masukkan tinggi balok:"
                read tinggi
                volume=$((panjang * lebar * tinggi))
                echo "Volume balok adalah $volume"
                ;;
            3) 
                echo "Masukkan jari-jari bola:"
                read jari
                volume=$(echo "scale=2; (4/3) * 3.14 * $jari * $jari * $jari" | bc)
                echo "Volume bola adalah $volume"
                ;;
            4) 
                echo "Masukkan jari-jari alas tabung:"
                read jari
                echo "Masukkan tinggi tabung:"
                read tinggi
                volume=$(echo "scale=2; 3.14 * $jari * $jari * $tinggi" | bc)
                echo "Volume tabung adalah $volume"
                ;;
            *) 
                echo "Pilihan tidak valid untuk bangun ruang."
                ;;
        esac

    else
        echo "Pilihan tidak valid."
    fi
}

# Fungsi untuk konversi mata uang
konversiMataUang() {
    echo "Masukkan jumlah uang dalam Rupiah:"
    read rupiah
    echo "Masukkan nilai tukar (contoh: 15000 untuk USD):"
    read nilai_tukar
    hasil=$(echo "scale=2; $rupiah / $nilai_tukar" | bc)
    echo "Hasil konversi: $hasil dalam mata uang asing."
}

hitungKalori() {
    echo "Masukkan nama makanan:"
    read makanan
    
    echo "Masukkan jumlah makanan (dalam gram):"
    read jumlah
    
    echo "Masukkan nilai kalori per 100 gram (dalam kalori):"
    read kalori_per_100g
    
    # Menghitung total kalori
    total_kalori=$(( (jumlah * kalori_per_100g) / 100 ))
    
    echo "Anda telah mengonsumsi $total_kalori kalori dari $jumlah gram $makanan."
}

# Menu utama
echo "Pilih program yang mau dijalankan:"
echo "1. Manipulasi hak akses"
echo "2. Membuka aplikasi"
echo "3. Kalkulator suhu"
echo "4. Menghitung luas bangun datar"
echo "5. Konversi mata uang"
echo "6. Menghitung kalori"

read pilihan

# Menentukan pilihan
if [ "$pilihan" -eq 1 ]; then
    manipulasiHakAkses
elif [ "$pilihan" -eq 2 ]; then
    membukaAplikasi
elif [ "$pilihan" -eq 3 ]; then
    kalkulatorSuhu
elif [ "$pilihan" -eq 4 ]; then
    menghitungLuasVolume
elif [ "$pilihan" -eq 5 ]; then
    konversiMataUang
elif [ "$pilihan" -eq 6 ]; then
    hitungKalori
else
    echo "Pilihan tidak valid."
fi
