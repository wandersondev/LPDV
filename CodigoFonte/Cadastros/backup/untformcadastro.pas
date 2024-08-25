unit untFormCadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ATStatusBar, BCPanel,
  BCButton, BCGradientButton, BCImageButton, BGRASpeedButton, DB;

type

  { TFormCadastro }

  TFormCadastro = class(TForm)
    ATStatus1: TATStatus;
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
  private

  public

  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.lfm}

end.

