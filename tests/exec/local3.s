	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $65, %rbx
	movq %rbx, %rdi
	call putchar
	movq $1, %rax
	movq %rbx, %rdi
	addq %rax, %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
	call putchar
	movq $1, %rax
	movq %rbx, %rdi
	addq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
