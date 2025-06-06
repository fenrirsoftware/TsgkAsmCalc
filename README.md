<br>
<br>

<h2>Ortam ve Araçlar</h2>
<ul>
    <li><strong>İşletim Sistemi:</strong> Ubuntu</li>
    <li><strong>Derleyici:</strong> NASM (Netwide Assembler)
    <li><strong>Linker:</strong> GNU ld</li>

</ul>

<h2>Özellikler</h2>
<ul>
    <li>Kullanıcıdan iki tamsayı ve bir işlem operatörü alma</li>
    <li>Toplama (+), çıkarma (-), çarpma (*), bölme (/) işlemleri</li>
    <li>Negatif sayı desteği</li>
    <li>Sıfıra bölme ve geçersiz giriş kontrolü</li>
</ul>

<h2>Kurulumu ve Çalıştırma</h2>
<ol>
    <li><strong>Depoyu Klonlayın:</strong>
        <pre><code>git clone https://github.com/fenrirsoftware/TsgkAsmCalc.git</code></pre>
    </li>
    <li><strong>Kodu Derleyin:</strong>
        <pre><code>nasm -f elf64 calc.asm -o calc.o</code></pre>
    </li>
    <li><strong>Obje Dosyasını Bağlayın:</strong>
        <pre><code>ld -o calc calc.o</code></pre>
    </li>
 
</ol>

<h2>Kullanım Örneği</h2>
<p>Program çalıştırıldığında, sırasıyla birinci sayı, ikinci sayı ve işlem operatörü istenir. Örnek:</p>
<pre><code>
./calc "+" 3 7
./calc "-" 3 7
./calc "*" 3 7 
./calc "/" 3 7 
</code></pre>
<p>Hatalı girişlerde (örneğin, sıfıra bölme veya geçersiz sayı) uygun hata mesajları gösterilir.</p>

<ul>
    <li>Kod yalnızca tamsayı işlemlerini destekler; ondalıklı sayılar desteklenmez.</li>
    <li>Linux x86_64 sisteminde test edilmiştir. Diğer platformlarda çalışması için uyarlama gerekebilir.</li>
</ul>

