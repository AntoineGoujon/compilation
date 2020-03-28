	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq $16, %rdi
	call sbrk
	movq %rax, -8(%rbp)
	movq -8(%rbp), %r15
	movq %r15, -16(%rbp)
	movq -16(%rbp), %rdi
	movq $65, %rdi
	movq -16(%rbp), %r15
	movq %rdi, 0(%r15)
	movq -8(%rbp), %rdi
	movq 0(%rdi), %rdi
	call putchar
	movq -16(%rbp), %rax
	movq 0(%rax), %rdi
	call putchar
	movq %rax, %rdi
	movq $66, %rdi
	movq -16(%rbp), %r15
	movq %rdi, 8(%r15)
	movq -8(%rbp), %rdi
	movq 8(%rdi), %rdi
	call putchar
	movq -16(%rbp), %rax
	movq 8(%rax), %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
