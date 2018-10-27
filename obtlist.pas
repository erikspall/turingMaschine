unit OBTList;

{$mode objfpc}{$H+} {$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils;

type

  { StringList }

  StringList = class
  private
    class var items: array of string;

  public

    procedure addItem(Text: string);
    class constructor init();
    procedure insertItem(Text: string; Index: integer);
    procedure replaceItem(Index: Integer; Text:String);
    procedure deleteItemAt(Index: integer);
    procedure deleteItem(Keyword: string);
    procedure Clear();
    function getItem(Index: integer): string;
    function isEmpty(): boolean;
    function size(): integer;
    function indexOf(Text:String):Integer;
    function compare(SomeList:StringList):Boolean;
  end;

  MyException = class(Exception)

  end;


implementation
function StringList.compare(SomeList:StringList):Boolean;
Var i:Integer;
begin
  if size() = SomeList.size() then
  begin
       for i:=0 to size-1 do
       begin
         if getItem(i) <> SomeList.getItem(i) then result:=false
       end;
       result:=true;
  end
  else
  begin
    result:=false;
    end;
end;

function StringList.indexOf(Text:String):Integer;
Var index:Integer;
begin
  index := 0;
   if Length(StringList.items) <> 0 then
   begin
     while (index < Length(StringList.items)) and (StringList.items[index] <> text)  do
     begin
       Inc(index);
     end;
     if index >= size() then
     begin
       raise MyException.Create('Item not in List');
     end
     else
     begin
       result:=index;
     end;

   end
   else
   begin
     raise MyException.Create('List is empty');
   end;
 end;


procedure StringList.Clear();
begin
  SetLength(StringList.items, 0);
end;

procedure StringList.insertItem(Text: string; Index: integer);
var
  i: integer;
  tempStr: string;
begin

  if (index = 0) and (Length(StringList.items) = 0) then
  begin
     addItem(Text);
  end
  else if (index < size) and (Index >= 0) then
  begin
  SetLength(StringList.items, size() + 1);
  for i := size - 1 downto index +1  do
  begin
    StringList.items[i] := StringList.items[i - 1];
  end;
  StringList.items[Index] := Text;

  end
  else
  begin
    raise myException.Create('Out of Bounds: Length: ' +
      size.toString + ' Index: ' + Index.toString);
  end;
end;

procedure StringList.replaceItem(Index: Integer; Text: String);
begin
   if index >= size then
  begin
    raise MyException.Create('Out of Bounds: Length: ' +
      Length(StringList.items).toString + ' Index: ' + Index.toString);
  end
  else
  begin
     StringList.items[index]:=Text;
  end;
end;

procedure StringList.deleteItemAt(Index: integer);
var
  tempS: string;
  i: integer;

begin
  if index >= size then
  begin
    raise MyException.Create('Out of Bounds: Length: ' +
      Length(StringList.items).toString + ' Index: ' + Index.toString);
  end
  else
  begin
    for i := index to size() - 2 do
    begin
      tempS := StringList.items[i + 1];
      StringList.items[i + 1] := StringList.items[i];
      StringList.items[i] := tempS;
    end;
    SetLength(StringList.items, size() - 1);

  end;

end;

procedure StringList.deleteItem(Keyword: string);
var
  index: integer;
begin
  index := 0;
  if Length(StringList.items) <> 0 then
  begin
    while (index < Length(StringList.items)) and (StringList.items[index] <> Keyword)  do
    begin
      Inc(index);
    end;
    if index >= size() then
    begin
      raise MyException.Create('Keyword not in List');
    end
    else
    begin
      deleteItemAt(index);
    end;

  end
  else
  begin
    raise MyException.Create('List is empty');
  end;
end;


function StringList.getItem(Index: integer): string;
begin
  Result := StringList.items[Index];
end;

procedure StringList.addItem(Text: string);
begin
  SetLength(StringList.items, Length(StringList.items) + 1);
  //SetLength(StringList.items,1);
  StringList.items[Length(StringList.items) - 1] := Text;
end;

class constructor StringList.init();
begin
  StringList.Create;
end;

function StringList.isEmpty(): boolean;
begin
  if size() = 0 then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function StringList.size(): integer;
var
  i: integer;
begin
  Result := Length(StringList.items);
end;

end.
