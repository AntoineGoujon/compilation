	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $104, %rdi
	call putchar
	movq %rax, %rdi
	movq $101, %rdi
	call putchar
	movq %rax, %rdi
	movq $108, %rdi
	call putchar
	movq %rax, %rdi
	movq $108, %rdi
	call putchar
	movq %rax, %rdi
	movq $111, %rdi
	call putchar
	movq $32, %rax
	movq %rax, %rdi
	call putchar
	movq $119, %rax
	movq %rax, %rdi
	call putchar
	movq $111, %rax
	movq %rax, %rdi
	call putchar
	movq $114, %rax
	movq %rax, %rdi
	call putchar
	movq $108, %rax
	movq %rax, %rdi
	call putchar
	movq $100, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
