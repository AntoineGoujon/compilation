	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rdi
	movq 0(%rdi), %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
