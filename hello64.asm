BITS 64
        org     0x01000000
hello:
        db      0x7F, "ELF"     ; e_ident
        db      "o, World!", 10
        db      0, 0
        dw      2               ; e_type
        dw      62              ; e_machine
        dd      1               ; e_version
        dq      _start          ; e_entry
        dq      phdr - $$       ; e_phoff
                                ; e_shoff
cont2:
        mov     AL, 4           ; write = 4
        int     0x80
        xchg    EAX, EDI        ; exit(0)
        xchg    EAX, EBX        ; exit = 1
        int     0x80
phdr:
        dd      1               ; e_flags & p_type
        dw      7               ; e_ehsize & p_flags
        dw      56              ; e_phentsize & p_flags
        dw      1               ; e_phnum & p_offset
        dw      0               ; e_shentsize & p_offset
        dw      0               ; e_shnum & p_offset
        dw      0               ; e_shstrndx & p_offset
        dq      $$ + 1          ; p_vaddr
                                ; p_paddr
_start:
        inc     EBX             ; stdout = 1
        mov     DL, 14          ; strlen = 14
        inc     ECX
        jmp     cont
        dq      filesize - 1    ; p_filesz
                                ; p_memsz
cont:
        shl     ECX, 24
        db      0x25            ; and EAX, 0 (fall through)
        db      0, 0, 0, 0
                                ; p_align
        xor     dword[RCX], 0x2a202037
        jmp     cont2
filesize equ    $ - $$
