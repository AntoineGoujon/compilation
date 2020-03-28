	.text
	.globl main
supprimer:
	pushq %rbp
	movq %rsp, %rbp
	movq 16(%rdi), %rcx
	movq 8(%rdi), %rsi
	movq %rcx, 16(%rsi)
	movq %rdi, %rcx
	movq 8(%rcx), %rax
	movq 16(%rdi), %rdi
	movq %rax, 8(%rdi)
	movq $0, %rax
	popq %rbp
	ret
afficher:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	movq -8(%rbp), %rdi
	movq 0(%rdi), %rdi
	call putchar
	movq -8(%rbp), %rax
	movq 16(%rax), %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rcx
L30:
	movq -16(%rbp), %rcx
	movq -8(%rbp), %rdi
	cmpq %rcx, %rdi
	setne %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L18
	movq -8(%rbp), %rdi
	movq 0(%rdi), %rdi
	call putchar
	movq -8(%rbp), %rax
	movq 16(%rax), %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	jmp L30
L18:
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq $65, %rdi
	call make
	movq %rax, -8(%rbp)
	movq -8(%rbp), %rdi
	movq -8(%rbp), %rdi
	call afficher
	movq %rax, %rsi
	movq $66, %rsi
	movq -8(%rbp), %rdi
	call inserer_apres
	movq %rax, %rdi
	movq -8(%rbp), %rdi
	call afficher
	movq %rax, %rsi
	movq $67, %rsi
	movq -8(%rbp), %rdi
	call inserer_apres
	movq %rax, %rdi
	movq -8(%rbp), %rdi
	call afficher
	movq -8(%rbp), %rax
	movq 16(%rax), %rdi
	call supprimer
	movq -8(%rbp), %rax
	movq %rax, %rdi
	call afficher
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
make:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq %rdi, %r12
	movq $24, %rdi
	call sbrk
	movq %rax, %rdi
	movq %r12, %rdi
	movq %rdi, 0(%rax)
	movq %rax, %rdi
	movq %rdi, 8(%rax)
	movq %rdi, 16(%rax)
	movq %rax, %rdi
	movq %rdi, %rax
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
inserer_apres:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq %rdi, %rbx
	movq %rsi, %rdi
	call make
	movq %rax, %rdi
	movq %rbx, %rdi
	movq 16(%rdi), %rcx
	movq %rcx, 16(%rax)
	movq %rax, %rcx
	movq %rbx, %rdi
	movq %rcx, 16(%rdi)
	movq %rax, %rcx
	movq 16(%rax), %rdi
	movq %rcx, 8(%rdi)
	movq %rbx, %rcx
	movq %rcx, 8(%rax)
	movq %rcx, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
