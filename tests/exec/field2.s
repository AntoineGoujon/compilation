	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $16, %rdi
	call sbrk
	movq %rax, %rbx
	movq %rbx, %rdi
	movq $65, %rdi
	movq %rdi, 0(%rbx)
	movq %rbx, %rdi
	movq 0(%rdi), %rdi
	call putchar
	movq $66, %rax
	movq %rbx, %rdi
	movq %rax, 8(%rdi)
	movq %rbx, %rax
	movq 8(%rax), %rdi
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
