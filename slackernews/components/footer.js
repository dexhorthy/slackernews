import { useState } from "react";
import { useRouter } from 'next/router'
import * as React from "react";

export default function Footer({ hideSearch, slackernewsVersion }) {
  const [searchInput, setSearchInput] = useState("");

  const router = useRouter();

  const onSearchKeyUp = (e) => {
    if (e.key === 'Enter' || e.keyCode === 13) {
      router.push(`/?q=${searchInput}`);
    }
  }

  return (
    <div className="container-fluid">
      <i style={{fontSize: "12px"}}>Slackernews version {slackernewsVersion}</i>
      {hideSearch ? null : (
        <div className="row">
          <div className="col-12">
            <div className="search">
              <div className="search__input">
                Search: <input
                  type="text"
                  value={searchInput}
                  onChange={
                    (e) => setSearchInput(e.target.value)
                  }
                  onKeyUp={onSearchKeyUp} />
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
