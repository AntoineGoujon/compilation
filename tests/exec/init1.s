	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq %rdi, %rcx
	cmpq %rcx, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L4
	movq $97, %rdi
	call putchar
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	jmp L4
	.data
