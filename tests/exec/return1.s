	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	addq $-32, %rsp
	movq %r12, -24(%rbp)
	movq %rbx, -32(%rbp)
	movq %rcx, %r12
	movq %rdx, %rbx
	movq %rsi, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %rdi
	cmpq $0, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L8
	movq $10, %rax
L1:
	movq -24(%rbp), %r12
	movq -32(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L8:
	movq -16(%rbp), %rdi
	call putchar
	movq %rax, %rdi
	movq -16(%rbp), %rdi
	movq %r12, %rdx
	movq %rbx, %rsi
	movq -8(%rbp), %rbx
	movq %rdi, %rcx
	movq %rbx, %rdi
	call f
	jmp L1
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rcx
	movq $67, %rdx
	movq $66, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
