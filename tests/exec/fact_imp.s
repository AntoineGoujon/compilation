	.text
	.globl main
fact_imp:
	pushq %rbp
	movq %rsp, %rbp
	movq $1, %rax
	movq %rax, %rcx
L18:
	movq $1, %rcx
	movq %rdi, %rsi
	cmpq %rcx, %rsi
	setg %sil
	movzbq %sil, %rsi
	cmpq $0, %rsi
	jz L2
	movq $1, %rsi
	movq $1, %rcx
	subq %rcx, %rdi
	movq %rdi, %rcx
	addq %rsi, %rcx
	imulq %rcx, %rax
	jmp L18
L2:
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq $1, -16(%rbp)
	movq $0, %rdi
	call fact_imp
	cmpq -16(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L39
	movq $49, %rdi
	call putchar
	movq %rax, -24(%rbp)
L39:
	movq $1, -24(%rbp)
	movq $1, %rdi
	call fact_imp
	cmpq -24(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L32
	movq $50, %rdi
	call putchar
	movq %rax, -8(%rbp)
L32:
	movq $120, -8(%rbp)
	movq $5, %rdi
	call fact_imp
	cmpq -8(%rbp), %rax
	sete %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L25
	movq $51, %rdi
	call putchar
	movq %rax, %rdi
L25:
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L25
	jmp L32
	jmp L39
	.data
