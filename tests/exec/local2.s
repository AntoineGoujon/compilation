	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %r12, -8(%rbp)
	movq %rbx, -16(%rbp)
	movq $65, %rbx
	movq %rbx, %rdi
	movq %rbx, %rdi
	call putchar
	movq $1, %rax
	addq %rax, %rbx
	movq %rbx, %rdi
	movq %rbx, %rdi
	call putchar
	movq %rax, %rcx
	movq $1, %rcx
	movq %rbx, %rdi
	addq %rcx, %rdi
	movq %rdi, %r12
	movq %r12, %rdi
	movq %rbx, %rdi
	call putchar
	movq %r12, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq -16(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
