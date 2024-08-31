unit untFuncoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils,Graphics, Forms,Dialogs, controls, ExtCtrls, Buttons, IniFiles;

function fMensagem(strTitulo: String;
                   strMensag: String;
                   arrOpcoes: Array Of String;
                   intFocBot: Integer = 1;
                   blnSaiEsc: Boolean = False;
                   intEstFon: Integer = 1;
                   intWidBut: Integer = 0): Integer;
procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
procedure pMsgErro(const strMsg: String);
function fEmptyStr(strString: String): Boolean;
function Crypt(vString: String) : String;
procedure LeConfiguracaoBanco;
function LeArquivoIni(arquivo,secao, valor: String):String;


implementation
      uses untFormMensagem, untConstantes, untDM;

function fMensagem(strTitulo: String; strMensag: String;
  arrOpcoes: array of String; intFocBot: Integer; blnSaiEsc: Boolean;
  intEstFon: Integer; intWidBut: Integer): Integer;
var
  intQtdOpc: Integer;
  intPosic : Integer;
  fntFonte : TFont;
begin
  intQtdOpc      := 0;
  fntFonte       := TFont.Create;
  fntFonte.Name  := 'Verdana';
  fntFonte.Size  := 8;
  fntFonte.Style := [fsBold];
  for intPosic := 0 To Length(arrOpcoes) - 1 do
  begin
    if (arrOpcoes[intPosic] <> '') then
      Inc(intQtdOpc)
    else
      Break;
  end;
  if (Length(arrOpcoes) = 2)   and
     (Trim(arrOpcoes[0]) = '') and
     (Trim(arrOpcoes[1]) = '') then
  begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
    intQtdOpc    := 2;
  end;
  if (Trim(arrOpcoes[0]) = '') then
  begin
    MessageDlg('É obrigatório a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  end;
  if (intFocBot <= 0)        or
     (intFocBot > intQtdOpc) then
    intFocBot := 1;
  try
    pCriarFormularios(TFormMensagem, FormMensagem);
    With FormMensagem Do
    Begin
      if (strTitulo = '') then
        strTitulo := 'Aviso';
      if (intEstFon = 2) then
        pnMensagem.Font.Name := 'Courier New';
      pnTitulo.Caption   := strTitulo;
      pnMensagem.Caption := strMensag;
      if (intQtdOpc = 1) then
      begin
        with TSpeedButton.Create(formMensagem) Do
        begin
          parent     := pnBotoes;
          if (intWidBut <> 0) then
            Left     := 156 - ((intWidBut - 156) Div 2)
          else
            Left     := 156;
          Top        := 05;
          Height     := 28;
          if (intWidBut = 0) then
            Width    := 126
          else
            Width    := intWidBut;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Cursor     := crHandPoint;

          OnClick := @formMensagem.pOnclick;

        end;
      end
      else if (intQtdOpc = 2) then
      begin
        with TSpeedButton.Create(formMensagem) do
        begin
          parent     := pnBotoes;
          if (intWidBut <> 0) then
            Left     := 90 - (intWidBut - 130)
          else
            Left     := 90;
          Top        := 05;
          Height     := 28;
          if (intWidBut = 0) then
            Width    := 130
          else
            Width    := intWidBut;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Cursor     := crHandPoint;
         // Picture    := TGDIPPicture(imgbotao1.Picture.Graphic);
          //Picture.Assign(imgbotao1.Picture);
          OnClick    := @formMensagem.pOnclick;
        end;
        with TSpeedButton.Create(formMensagem) do
        begin
          parent     := pnBotoes;
          Left       := 222;
          Top        := 05;
          Height     := 28;
          if (intWidBut = 0) then
            Width    := 130
          else
            Width    := intWidBut;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Cursor     := crHandPoint;
          //Picture    := TGDIPPicture(imgbotao2.Picture.Bitmap);
          OnClick    := @formMensagem.pOnclick;
        end;
      end
      else if (intQtdOpc = 3) then
      begin
        with TSpeedButton.Create(formMensagem) do
        begin
          parent     := pnBotoes;
          Left       := 28;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Cursor     := crHourGlass;
          //Picture    := TGDIPPicture(imgbotao1.Picture.Bitmap);
          OnClick    := @formMensagem.pOnclick;
        end;
        with TSpeedButton.Create(formMensagem) do
        begin
          parent     := pnBotoes;
          Left       := 156;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Cursor     := crHandPoint;
          //Picture    := TGDIPPicture(imgbotao2.Picture.Bitmap);
          OnClick    := @formMensagem.pOnclick;
        end;
        with TSpeedButton.Create(formMensagem) do
        begin
          parent     := pnBotoes;
          Left       := 284;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          Cursor     := crHandPoint;
          //Picture    := TGDIPPicture(imgbotao3.Picture.Bitmap);
          OnClick    := @formMensagem.pOnclick;
        end;
      end;
    end;
    formMensagem.intFocus  := intFocBot;
    formMensagem.blnSaiEsc := blnSaiEsc;
    formMensagem.ShowModal;
    Result := formMensagem.intRetorn;
  except
    on E: Exception do
    begin
      Result := 0;
      pMsgErro(E.Message);
    end;
  end;
  FreeAndNil(formMensagem);
  FreeAndNil(fntFonte);
end;

procedure pCriarFormularios(Classe: TComponentClass; var frmForm);
var
  intCon: Integer;
  strMsg: String;
Begin
  strMsg := '';
  for intCon := 0 To 4 do
  begin
    try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    except
      on E: Exception do
        strMsg := E.Message + ' ' + E.ClassName;
    end;

    if fEmptyStr(strMsg) then
      Break;

    Application.ProcessMessages;
    Sleep(1500);
  end;
  if not fEmptyStr(strMsg) then
    raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);
end;

procedure pMsgErro(const strMsg: String);
begin
  fMensagem('Erro', strMsg, ['&OK']);
end;

function fEmptyStr(strString: String): Boolean;
begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  if (AnsiReplaceText(strString, ' ', '') = '') then
    Result := True;
end;

function Crypt(vString: string): string;
var
  i, ordem: integer;
begin
  Result := '';
  for i := 1 to Length(vString) do
  begin
    ordem := Ord(vString[i]);
    ordem += 3;
    Result += Chr(ordem);
  end;
end;

procedure LeConfiguracaoBanco;
begin
  try
    if(FileExists(DADOS_CONEXAO))then
    begin
      tipo       := LeArquivoIni(DADOS_CONEXAO, 'DADOS','TIPO');
      banco      := LeArquivoIni(DADOS_CONEXAO, 'DADOS','BANCO');
      ip         := LeArquivoIni(DADOS_CONEXAO, 'DADOS','IP');
      usuario    := LeArquivoIni(DADOS_CONEXAO, 'DADOS','USUARIO');
      senha      := LeArquivoIni(DADOS_CONEXAO, 'DADOS','SENHA');
    end;
  except

  end;
end;

function LeArquivoIni(arquivo, secao, valor: String): String;
var
  iniArq: TIniFile;
begin
  iniArq := TIniFile.Create(arquivo);
  try
    Result := iniArq.ReadString(secao, valor,'Default');
  finally
    iniArq.Free;
  end;

end;

end.

