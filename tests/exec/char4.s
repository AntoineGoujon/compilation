	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	addq %rsi, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq $0, %rcx
	movq $65, %rdi
	movq %rcx, %rsi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $1, %rcx
	movq $65, %rdi
	movq %rcx, %rsi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rsi
	movq $2, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rsi
	movq $3, %rsi
	movq $65, %rdi
	call f
	movq %rax, -8(%rbp)
	movq -8(%rbp), %rdi
	movq -8(%rbp), %rdi
	call putchar
	movq $1, %rax
	movq -8(%rbp), %rdi
	addq %rax, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	movq -8(%rbp), %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
