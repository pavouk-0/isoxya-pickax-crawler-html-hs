module ISX.Plug.CrawlerHTML.Route (site) where


import              Snap.Core
import qualified    ISX.Plug.CrawlerHTML.Zone.Common.Apex   as  ZA
import qualified    ISX.Plug.CrawlerHTML.Zone.Common.Data   as  ZD
import qualified    TPX.Com.API.Res                         as  Res


site :: Snap ()
site = ifTop ZA.apex <|> route [
    -- COMMON
    ("data",                            method POST     ZD.create),
    ("data/:_",                                         notFound),
    --
    ("",                                                notFound)]
    where
        notFound = Res.notFound