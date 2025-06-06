section .data
    AZ_ARG: db "biseyler eksik", 0xA
    GECERSIZ_ISLEM: db "Geçersiz işlem", 0xA
    GECERSIZ_SAYI: db "Geçersiz sayı", 0xA
    CIKTI_BELLEK: times 10 db 0

section .text
    global _start

_start:
    pop rdx
    cmp rdx, 4
    jne hata_az_arg
    add rsp, 8
    pop rsi

    cmp byte[rsi], 0x2A
    je carp
    cmp byte[rsi], 0x78
    je carp
    cmp byte[rsi], 0x2B
    je topla
    cmp byte[rsi], 0x2D
    je cikar
    cmp byte[rsi], 0x2F
    je bol
    cmp byte[rsi], 0x25
    je mod

    jmp hata_islem

topla:
    pop rsi
    call yazi_sayi
    mov r10, rax
    pop rsi
    call yazi_sayi
    add rax, r10
    jmp yazdir

cikar:
    pop rsi
    call yazi_sayi
    mov r10, rax
    pop rsi
    call yazi_sayi
    sub r10, rax
    mov rax, r10
    jmp yazdir

carp:
    pop rsi
    call yazi_sayi
    mov r10, rax
    pop rsi
    call yazi_sayi
    mul r10
    jmp yazdir

bol:
    pop rsi
    call yazi_sayi
    mov r10, rax
    pop rsi
    call yazi_sayi
    mov r11, rax
    mov rax, r10
    xor rdx, rdx
    div r11
    jmp yazdir

mod:
    pop rsi
    call yazi_sayi
    mov r10, rax
    pop rsi
    call yazi_sayi
    mov r11, rax
    mov rax, r10
    xor rdx, rdx
    div r11
    mov rax, rdx
    jmp yazdir

yazdir:
    call sayi_yazi
    mov rax, 1
    mov rdi, 1
    mov rsi, r9
    mov rdx, r11
    syscall
    jmp cikis

hata_az_arg:
    mov rdi, AZ_ARG
    call hata_yaz
hata_islem:
    mov rdi, GECERSIZ_ISLEM
    call hata_yaz
hata_sayi:
    mov rdi, GECERSIZ_SAYI
    call hata_yaz

hata_yaz:
    push rdi
    call metin_uzunluk
    mov rdi, 2
    pop rsi
    mov rdx, rax
    mov rax, 1
    syscall
    call hata_cikis
    ret

metin_uzunluk:
    xor rax, rax
.yinele:
    cmp byte [rdi + rax], 0xA
    je .bitir
    inc rax
    jmp .yinele
.bitir:
    inc rax
    ret

yazi_sayi:
    xor ax, ax
    xor cx, cx
    mov bx, 10
.surekli:
    mov cl, [rsi]
    cmp cl, 0
    je .don
    cmp cl, 0x30
    jl hata_sayi
    cmp cl, 0x39
    jg hata_sayi
    sub cl, 48
    mul bx
    add ax, cx
    inc rsi
    jmp .surekli
.don:
    ret

sayi_yazi:
    mov rbx, 10
    mov r9, CIKTI_BELLEK+10
    mov [r9], byte 0
    dec r9
    mov [r9], byte 0xA
    dec r9
    mov r11, 2
.ayir:
    xor rdx, rdx
    div rbx
    cmp rax, 0
    je .son
    add dl, 48
    mov [r9], dl
    dec r9
    inc r11
    jmp .ayir
.son:
    add dl, 48
    mov [r9], dl
    dec r9
    inc r11
    ret

hata_cikis:
    mov rax, 60
    mov rdi, 1
    syscall

cikis:
    mov rax, 60
    xor rdi, rdi
    syscall

; Rache is back, and he's got your brain!
