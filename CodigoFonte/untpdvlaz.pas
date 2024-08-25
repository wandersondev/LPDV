unit untPDVLaz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormPDVLaz }

  TFormPDVLaz = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  FormPDVLaz: TFormPDVLaz;

implementation
   uses untFormCadastroPadrao, untFormCadastro;
{$R *.lfm}

{ TFormPDVLaz }

procedure TFormPDVLaz.Button1Click(Sender: TObject);
   var FormCadastroPadrao: TFormCadastroPadrao;
begin
  // identificar qual form está ativo dentro do FormPrincipal
  // fechar este form e em seguida rodar o código abaixo
  FormCadastroPadrao := TFormCadastroPadrao.Create(Self);
  FormCadastroPadrao.Show;

end;

procedure TFormPDVLaz.Button2Click(Sender: TObject);
var FormCadastro: TFormCadastro;
begin

end;

end.

