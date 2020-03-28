	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rdi
	movq $1, %rax
	cqto
	idivq %rdi
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
