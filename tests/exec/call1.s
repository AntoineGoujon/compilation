	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	call putchar
	movq $0, %rax
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $66, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rcx
	movq $65, %rcx
	movq $66, %rdi
	movq %rcx, %rsi
	call f
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
