// un exemple de fichier mini-C
// à modifier au fur et à mesure des tests
//
// la commande 'make' recompile mini-c (si nécessaire)
// et le lance sur ce fichier

struct S { int a; int b; };

int main() {
  struct S *s;
  s = sbrk(sizeof(struct S));
  s->a = 'A';
  putchar(s->a);
  s->b = 'B';
  putchar(s->b);
  putchar(10);
  return 0;
}
