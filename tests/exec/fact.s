	.text
	.globl main
fact:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq %rdi, %rbx
	movq $1, %rdi
	movq %rbx, %rcx
	cmpq %rdi, %rcx
	jle L8
	movq $1, %rcx
	movq %rbx, %rdi
	subq %rcx, %rdi
	call fact
	imulq %rax, %rbx
L1:
	movq %rbx, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L8:
	movq $1, %rbx
	jmp L1
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq $0, %r12
	movq %r12, %rdi
L29:
	movq $4, %rdi
	cmpq %rdi, %r12
	jle L26
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
L26:
	movq %r12, %rdi
	call fact
	movq %rax, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $1, %rax
	addq %rax, %r12
	movq %r12, %rdi
	jmp L29
	.data
