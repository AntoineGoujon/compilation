	.text
	.globl main
print:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq %rdi, %r12
	movq $40, %rdi
	call putchar
	movq $0, %rax
	movq 16(%r12), %rdi
	cmpq %rax, %rdi
	setne %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L14
	movq 16(%r12), %rdi
	call print
L14:
	movq %r12, %rax
	movq 0(%rax), %rdi
	call print_int
	movq $0, %rax
	movq %r12, %rdi
	movq 8(%rdi), %rdi
	cmpq %rax, %rdi
	setne %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L3
	movq %r12, %rdi
	movq 8(%rdi), %rdi
	call print
L3:
	movq $41, %rax
	movq %rax, %rdi
	call putchar
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L3
	jmp L14
print_int:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %rdi, -16(%rbp)
	movq $10, %rdi
	movq -16(%rbp), %r15
	movq %r15, -8(%rbp)
	movq -8(%rbp), %rax
	cqto
	idivq %rdi
	movq %rax, -8(%rbp)
	movq -8(%rbp), %rcx
	movq $9, %rcx
	movq -16(%rbp), %rdi
	cmpq %rcx, %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L34
	movq -8(%rbp), %rdi
	call print_int
L34:
	movq -8(%rbp), %rax
	movq $10, %rdi
	imulq %rax, %rdi
	subq %rdi, -16(%rbp)
	movq $48, %rdi
	addq -16(%rbp), %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L34
contient:
	pushq %rbp
	movq %rsp, %rbp
	movq 0(%rdi), %rdx
	movq %rsi, %rcx
	cmpq %rdx, %rcx
	sete %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L69
	movq $1, %rax
L46:
	popq %rbp
	ret
L69:
	movq 0(%rdi), %rcx
	movq %rsi, %rdx
	cmpq %rcx, %rdx
	jl L65
L56:
	movq $0, %rdx
	movq 8(%rdi), %rcx
	cmpq %rdx, %rcx
	setne %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L47
	movq %rsi, %rcx
	movq 8(%rdi), %rdi
	movq %rcx, %rsi
	call contient
	jmp L46
L47:
	movq $0, %rax
	jmp L46
L65:
	movq $0, %rdx
	movq 16(%rdi), %rcx
	cmpq %rdx, %rcx
	setne %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L56
	movq %rsi, %rcx
	movq 16(%rdi), %rdi
	movq %rcx, %rsi
	call contient
	jmp L46
	jmp L56
insere:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq %rsi, %rcx
	movq %rdi, %rbx
	movq 0(%rbx), %rsi
	movq %rcx, %rdi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L113
	movq $0, %rcx
L76:
	movq %rcx, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L113:
	movq 0(%rbx), %rdi
	cmpq %rdi, %rcx
	jl L93
	movq $0, %rsi
	movq %rbx, %rdi
	movq 8(%rdi), %rdi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L104
	movq $0, %rdx
	movq $0, %rsi
	movq %rcx, %rdi
	call make
	movq %rax, 8(%rbx)
	movq %rax, %rdi
L77:
	movq $0, %rcx
	jmp L76
L104:
	movq 8(%rbx), %rdi
	movq %rcx, %rsi
	call insere
	movq %rax, %rdx
	jmp L77
L93:
	movq $0, %rdi
	movq 16(%rbx), %rsi
	cmpq %rdi, %rsi
	sete %sil
	movzbq %sil, %rsi
	cmpq $0, %rsi
	jz L88
	movq $0, %rdx
	movq $0, %rsi
	movq %rcx, %rdi
	call make
	movq %rax, %rcx
	movq %rcx, 16(%rbx)
	jmp L77
L88:
	movq %rcx, %rsi
	movq 16(%rbx), %rdi
	call insere
	movq %rax, %rdx
	jmp L77
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq $0, %rdx
	movq $0, %rsi
	movq $1, %rdi
	call make
	movq %rax, %r12
	movq %r12, %rdi
	movq $17, %rdi
	movq %rdi, %rsi
	movq %r12, %rdi
	call insere
	movq %rax, %rcx
	movq $5, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call insere
	movq %rax, %rcx
	movq $8, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call insere
	movq %r12, %rax
	movq %rax, %rdi
	call print
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $5, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call contient
	movq %rax, %rdi
	cmpq $0, %rdi
	jz L134
	movq $0, %rdi
	movq %rdi, %rsi
	movq %r12, %rdi
	call contient
	cmpq $0, %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L134
	movq $17, %rsi
	movq %r12, %rdi
	call contient
	movq %rax, %rdi
	cmpq $0, %rdi
	jz L134
	movq $3, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call contient
	movq %rax, %rdi
	cmpq $0, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L134
	movq $111, %rdi
	call putchar
	movq %rax, %rdi
	movq $107, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
L134:
	movq $42, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call insere
	movq %rax, %rcx
	movq $1000, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call insere
	movq %rax, %rcx
	movq $0, %rcx
	movq %r12, %rdi
	movq %rcx, %rsi
	call insere
	movq %r12, %rax
	movq %rax, %rdi
	call print
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L134
	jmp L134
	jmp L134
	jmp L134
make:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rbx, -24(%rbp)
	movq %rdx, %rbx
	movq %rsi, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq $24, %rdi
	call sbrk
	movq %rax, %rdi
	movq %rdi, %rcx
	movq -16(%rbp), %rcx
	movq %rcx, 0(%rdi)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rdi)
	movq %rbx, %rcx
	movq %rcx, 8(%rdi)
	movq %rdi, %rcx
	movq %rcx, %rax
	movq -24(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
