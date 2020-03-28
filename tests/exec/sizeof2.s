	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $8, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $16, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
