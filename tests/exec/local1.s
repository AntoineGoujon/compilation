	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $65, %rdi
	movq %rdi, %rax
	movq %rax, %rdi
	call putchar
	movq $66, %rax
	movq %rax, %rdi
	call putchar
	movq $67, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
