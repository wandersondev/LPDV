unit ufrmsplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LazFileUtils;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    ImageSplash: TImage;
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
  ImageSplash.Picture.LoadFromFile(GetForcedPathDelims('..\Imagens\logo_lazarus.png'));
end;

end.

