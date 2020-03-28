	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq $65, %rdi
	movq %rdi, %r12
	movq %r12, %rdi
	movq %r12, %rdi
	call putchar
	movq $1, %rax
	movq %r12, %rdi
	addq %rax, %rdi
	movq %rdi, %r12
	movq %r12, %rdi
	movq %r12, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
