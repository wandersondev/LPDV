unit ufrmsplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LazFileUtils;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(GetForcedPathDelims('..\Imagens\logo_lazarus.png'));
end;

end.

