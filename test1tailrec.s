	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	addq $-32, %rsp
L26:
	movq %r12, %r8
	movq %rcx, -32(%rbp)
	movq %rdx, -24(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	cmpq $0, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L8
	movq $10, %rdi
	movq %rdi, %rax
	movq %r8, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
L8:
	movq -8(%rbp), %rdi
	call putchar
	movq %rax, %rcx
	movq -8(%rbp), %rcx
	movq -32(%rbp), %rdx
	movq -24(%rbp), %rsi
	movq -16(%rbp), %rdi
	jmp L26
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq $0, %rcx
	movq $67, %rdx
	movq $66, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
