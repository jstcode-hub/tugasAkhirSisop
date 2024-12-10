#!/bin/bash

manipulasiHakAkses() {
    echo "Apakah Anda ingin memanipulasi hak akses file atau direktori? (file/direktori)"
    read jenis

    echo "Apakah Anda ingin memanipulasi file/direktori yang sudah ada atau membuat baru? (sudah/membuat)"
    read pilihan

    if [ "$pilihan" = "membuat" ]; then
        echo "Masukkan nama file/direktori baru:"
        read nama_baru
        if [ "$jenis" = "file" ]; then
            touch "$nama_baru"
        else
            mkdir "$nama_baru"
        fi
        target="$nama_baru"
    else
        echo "Masukkan nama file/direktori yang akan dimanipulasi:"
        read target
    fi

    if [ ! -e "$target" ]; then
        echo "File atau direktori $target tidak ditemukan!"
        return
    fi

    echo "Apakah Anda ingin memasukkan file/direktori ini ke dalam grup baru? (ya/tidak)"
    read ubah_grup

    if [ "$ubah_grup" = "ya" ]; then
        echo "Masukkan nama grup baru:"
        read nama_grup
        if ! grep -q "^$nama_grup:" /etc/group; then
            echo "Grup $nama_grup belum ada, membuat grup baru..."
            sudo groupadd "$nama_grup"
        else
            echo "Grup $nama_grup sudah ada."
        fi
        echo "Mengubah kepemilikan grup untuk $target ke $nama_grup..."
        sudo chgrp "$nama_grup" "$target"
        echo "Kepemilikan grup telah diubah."
    fi

    echo "Apakah Anda ingin menambahkan atau menghapus hak akses? (tambah/hapus)"
    read operasi

    echo "Pilih target hak akses: (user/u, grup/g, others/o, semua/a)"
    read target_hak

    echo "Masukkan hak akses yang akan dimanipulasi (r, w, x):"
    read hak_akses

    if [ "$operasi" = "tambah" ]; then
        chmod "$target_hak+$hak_akses" "$target"
        echo "Hak akses $hak_akses telah ditambahkan pada $target untuk $target_hak."
    elif [ "$operasi" = "hapus" ]; then
        chmod "$target_hak-$hak_akses" "$target"
        echo "Hak akses $hak_akses telah dihapus dari $target untuk $target_hak."
    else
        echo "Operasi tidak valid."
    fi

    echo "Operasi selesai dilakukan pada $target."
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
        case "$tujuan" in
            1) hasil=$suhu ;;
            2) hasil=$(echo "scale=2; ($suhu * 9/5) + 32" | bc) ;;
            3) hasil=$(echo "scale=2; $suhu + 273.15" | bc) ;;
            4) hasil=$(echo "scale=2; $suhu * 4/5" | bc) ;;
        esac
    elif [ "$asal" -eq 2 ]; then
        case "$tujuan" in
            1) hasil=$(echo "scale=2; ($suhu - 32) * 5/9" | bc) ;;
            2) hasil=$suhu ;;
            3) hasil=$(echo "scale=2; (($suhu - 32) * 5/9) + 273.15" | bc) ;;
            4) hasil=$(echo "scale=2; ($suhu - 32) * 4/9" | bc) ;;
        esac
    elif [ "$asal" -eq 3 ]; then
        case "$tujuan" in
            1) hasil=$(echo "scale=2; $suhu - 273.15" | bc) ;;
            2) hasil=$(echo "scale=2; (($suhu - 273.15) * 9/5) + 32" | bc) ;;
            3) hasil=$suhu ;;
            4) hasil=$(echo "scale=2; ($suhu - 273.15) * 4/5" | bc) ;;
        esac
    elif [ "$asal" -eq 4 ]; then
        case "$tujuan" in
            1) hasil=$(echo "scale=2; $suhu * 5/4" | bc) ;;
            2) hasil=$(echo "scale=2; (($suhu * 9/4) + 32)" | bc) ;;
            3) hasil=$(echo "scale=2; ($suhu * 5/4) + 273.15" | bc) ;;
            4) hasil=$suhu ;;
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

# Fungsi untuk menghitung IPK
menghitungIPK() {

    echo "Masukkan jumlah IPS uang akan dimasukkan: "
    read jumlah_ips

    ips=()
    for (( ipsMasuk=1; ipsMasuk<=$jumlah_ips; ipsMasuk++ ))
    do
        echo "Masukkan IPS ke-$ipsMasuk: "
        read ip
        ips+=($ip)
    done

    jumlahTotalIps=0

    for nilaiIps in "${ips[@]}"
    do
        jumlahTotalIps=$(echo "scale=2; $jumlahTotalIps + $nilaiIps" | bc)
    done

    ipk=$(echo "scale=2; $jumlahTotalIps / $jumlah_ips" | bc)

    echo "IPK anda: $jumlahTotalIps / $jumlah_ips"
    echo "IPK Anda adalah $ipk"
}

# Menu utama
echo "Pilih program yang mau dijalankan:"
echo "1. Manipulasi hak akses"
echo "2. Membuka aplikasi"
echo "3. Kalkulator suhu"
echo "4. Menghitung luas bangun datar"
echo "5. Menghitung IPK"

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
    menghitungIPK
else
    echo "Pilihan tidak valid."
fi
