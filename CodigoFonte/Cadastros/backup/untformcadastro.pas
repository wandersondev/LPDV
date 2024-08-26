unit untFormCadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls, StdCtrls ,Dialogs,  BCPanel, BGRASpeedButton, DB, windows;

type

  { TFormCadastro }

  TFormCadastro = class(TForm)
    btnNovo: TBGRASpeedButton;
    btnFechar: TBGRASpeedButton;
    btnPesquisar: TBGRASpeedButton;
    btnExcluir: TBGRASpeedButton;
    btnAlterar: TBGRASpeedButton;
    btnGravar: TBGRASpeedButton;
    dtsCadastro: TDataSource;
    pnBarra: TBCPanel;
    pnFundo: TBCPanel;
    pnStatus: TBCPanel;
    procedure ATStatus1Click(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.lfm}

{ TFormCadastro }

procedure TFormCadastro.ATStatus1Click(Sender: TObject);
begin

end;

procedure TFormCadastro.btnAlterarClick(Sender: TObject);
begin
  ShowMessage('Apertou alterar');
end;

procedure TFormCadastro.btnExcluirClick(Sender: TObject);
begin
  ShowMessage('Apertou excluir'+Sender.ToString);
end;

procedure TFormCadastro.btnFecharClick(Sender: TObject);
begin
  ShowMessage('Apertou fechar');
end;

procedure TFormCadastro.btnGravarClick(Sender: TObject);
begin
  ShowMessage('Apertou gravar');
end;

procedure TFormCadastro.btnNovoClick(Sender: TObject);
begin
  ShowMessage('Apertou novo');
end;

procedure TFormCadastro.btnPesquisarClick(Sender: TObject);
begin
  ShowMessage('Apertou pesquisar');
end;

procedure TFormCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
         VK_ESCAPE: btnFechar.Click;
         VK_F2: if btnNovo.Enabled then btnNovo.Click;
         VK_F10: if btnGravar.Enabled then btnGravar.Click;
         VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
         VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
         VK_F5: if btnPesquisar.Enabled then btnPesquisar.Click;
     end;

end;
  initialization
  Classes.RegisterClass(TFormCadastro);
  finalization
  Classes.UnregisterClass(TFormCadastro);

end.

