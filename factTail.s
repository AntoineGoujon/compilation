	.text
	.globl main
fact:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rdx
	movq %rsi, %rcx
L12:
	movq $1, %rax
	movq %rcx, %rsi
	cmpq %rax, %rsi
	jle L9
	movq $1, %rsi
	movq %rcx, %rax
	subq %rsi, %rax
	movq %rdi, %rsi
	movq %rcx, %rdi
	imulq %rsi, %rdi
	movq %rax, %rcx
	jmp L12
L9:
	movq %rdi, %rax
	movq %rdx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq $5, %rcx
	movq $1, %rdi
	movq %rcx, %rsi
	call fact
	movq %rax, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
