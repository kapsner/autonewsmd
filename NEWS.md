

# autonewsmd NEWS

## Unreleased (2025-11-15)

#### New features

-   added pre-commit hook to create changelog
    ([000055c](https://github.com/kapsner/autonewsmd/tree/000055c456908e31e6e32e7dacbf0779cbd80d0c))
-   added pre-commit hook to create changelog
    ([d88e99e](https://github.com/kapsner/autonewsmd/tree/d88e99e435e8651f75110bc7ec46c8d5075e9893))

#### Other changes

-   fixed error handling of corrupt quarto installation
    ([93a828f](https://github.com/kapsner/autonewsmd/tree/93a828ffd22db1fbfb7d7e3cc443d352968165f6))

Full set of changes:
[`v0.0.9...000055c`](https://github.com/kapsner/autonewsmd/compare/v0.0.9...000055c)

## v0.0.9 (2024-10-15)

#### Bug fixes

-   readded vignette
    ([6174204](https://github.com/kapsner/autonewsmd/tree/6174204ebbf295170eab4352eb58026a83a4c54b))
-   fixes impending cran-ban of git2r
    ([c9b7046](https://github.com/kapsner/autonewsmd/tree/c9b7046a71cd18c3f753ce928e644536471e0aa3))
-   first try to fix issues with quarto vignette on macosx cran runners
    ([3e3190a](https://github.com/kapsner/autonewsmd/tree/3e3190a8cf831ffcf8bbc95d11c77efad953553f))

#### Other changes

-   added default-image-extension to templateto prevent occuring of
    strange errors
    ([d9fc76a](https://github.com/kapsner/autonewsmd/tree/d9fc76a1b4f548f615fd468af37d55f5196cc6b2))
-   moved to quarto as vignette engine
    ([610e7b5](https://github.com/kapsner/autonewsmd/tree/610e7b5f14b3d69063b4b204ae3e23842be766d2))

Full set of changes:
[`v0.0.8...v0.0.9`](https://github.com/kapsner/autonewsmd/compare/v0.0.8...v0.0.9)

## v0.0.8 (2024-05-29)

#### Bug fixes

-   hotfix to address quarto cran issue on macos
    ([959f6da](https://github.com/kapsner/autonewsmd/tree/959f6da372a94c95fc44edd045d6c75d22fd962f))

## v0.0.7 (2024-05-27)

#### Bug fixes

-   merged fix regarding gitlab-comparison urls into development
    ([9033c3c](https://github.com/kapsner/autonewsmd/tree/9033c3cdad0f306411459422bae8fdd59a0d060f))
-   fixed issue with presence of multiple associated remote repos
    ([341960a](https://github.com/kapsner/autonewsmd/tree/341960a531c04d2058112f3be77213d76b917915))
-   moving from rmarkdown to quarto for rendering news.md
    ([80a8fca](https://github.com/kapsner/autonewsmd/tree/80a8fcaa4b2397e9db29b70cabd4902a3ac47604))
-   addresses issue with gitlab comparison found by @joundso
    ([c5ae722](https://github.com/kapsner/autonewsmd/tree/c5ae7220459f6ca73daeafa72fa27e341125189c))
-   “compare”-url generation now has a slash in it
    ([b7afdc1](https://github.com/kapsner/autonewsmd/tree/b7afdc1f640754e0f24e2f5372818758da3956a8))

#### CI

-   updated gha
    ([982578f](https://github.com/kapsner/autonewsmd/tree/982578fc26a97a0d862cc282243b83dbd20f4c8f))
-   another try to fix tinytex-installation on macos
    ([c10cb1b](https://github.com/kapsner/autonewsmd/tree/c10cb1b0fa4fa46c5a07d7cd7fd5a69b74b3d4cd))
-   re-introduced pandoc installation for macos runners
    ([54b022b](https://github.com/kapsner/autonewsmd/tree/54b022be62defe118f307fcbeead00efdf1485f2))
-   added quarto installation to gha
    ([11adf80](https://github.com/kapsner/autonewsmd/tree/11adf8057a1ebae1a1965bf50da9a563432267f2))

#### Other changes

-   version bump to 0.0.7
    ([2154de3](https://github.com/kapsner/autonewsmd/tree/2154de39f66d104933befaf8f5f086dd71f641d5))
-   fixed deps url
    ([ab71f0d](https://github.com/kapsner/autonewsmd/tree/ab71f0df685c3e99ab8cf610580c5a1e1ad277ae))
-   removed default image extension causing errors with badge urls
    ([0bdeb96](https://github.com/kapsner/autonewsmd/tree/0bdeb96587b772422713655910cb8398898a834c))
-   added readme.qmd and urls displaying asis
    ([6db029b](https://github.com/kapsner/autonewsmd/tree/6db029b994c7a625656617d1c923d9a6d9c34feb))
-   now with automatically generated readme
    ([8abcbe9](https://github.com/kapsner/autonewsmd/tree/8abcbe93dfc967d4b98613aed19eb6c55075b9a2))
-   changed docs to avoid tools::checkRd complaining about regex pattern
    ([c4b6773](https://github.com/kapsner/autonewsmd/tree/c4b67737987bb24d2068417b4c8f467c4aaa65e2))
-   updated news.md
    ([d30b576](https://github.com/kapsner/autonewsmd/tree/d30b5763581648c3da3b7710322c97b09b2d2392))
-   added message to indicate location of copied output file
    ([1ce501a](https://github.com/kapsner/autonewsmd/tree/1ce501a70ee2527690fbde553f4c467779ecbc96))
-   updated latest dev version
    ([903fff6](https://github.com/kapsner/autonewsmd/tree/903fff66efc2114f822971022343f3b96389ff9c))
-   updated description
    ([77dc1d9](https://github.com/kapsner/autonewsmd/tree/77dc1d9d64b821d036e50f0c565c9c9abf91bf4e))
-   updated news.md to v0.0.6
    ([a5f4da2](https://github.com/kapsner/autonewsmd/tree/a5f4da2cc998e36ee5dfd4fa7635ec9d0364067e))

Full set of changes:
[`v0.0.6...v0.0.7`](https://github.com/kapsner/autonewsmd/compare/v0.0.6...v0.0.7)

## v0.0.6 (2023-04-13)

#### Other changes

-   more informative error messages
    ([04f115a](https://github.com/kapsner/autonewsmd/tree/04f115aad0cb53c517e0e04cce08b8e53f07b939))
-   added pkg to readme
    ([c84e5ec](https://github.com/kapsner/autonewsmd/tree/c84e5ecec14804c9775ef512822dd4aeb6b977d6))

Full set of changes:
[`v0.0.5...v0.0.6`](https://github.com/kapsner/autonewsmd/compare/v0.0.5...v0.0.6)

## v0.0.5 (2023-01-21)

#### Other changes

-   merged yihuis patch
    ([851b893](https://github.com/kapsner/autonewsmd/tree/851b893cd39bd7fee18249bcf5a1a7b4e5f4e803))
-   updated readme, news.md
    ([647a8c7](https://github.com/kapsner/autonewsmd/tree/647a8c7e26e7d95f57a204683c7767541980e380))
-   fixed cran-checks badge
    ([f24b8e5](https://github.com/kapsner/autonewsmd/tree/f24b8e55fa4e376b7d2bca039b66d831310d51d4))
-   added authors-block to readme
    ([a9211ea](https://github.com/kapsner/autonewsmd/tree/a9211ea4994e5d53aff9989f43afbb33a094a094))
-   added mlsurvlrnrs pkg to used by section
    ([3d5a012](https://github.com/kapsner/autonewsmd/tree/3d5a012643fd6bedb54e23ffd870d6447cadbb63))
-   merge pull request #5 from kapsner/development
    ([3b07f0a](https://github.com/kapsner/autonewsmd/tree/3b07f0afe953e11194b81fcf0ada306dee191bb3))
-   updated news.md
    ([5decf24](https://github.com/kapsner/autonewsmd/tree/5decf248ec4b12bcdc54baeedf631075657fad5a))

Full set of changes:
[`v0.0.4...v0.0.5`](https://github.com/kapsner/autonewsmd/compare/v0.0.4...v0.0.5)

## v0.0.4 (2022-10-31)

#### New features

-   finalizing support for breaking changes
    ([214ebf5](https://github.com/kapsner/autonewsmd/tree/214ebf5fd07cad4a1b8556bd18272c3432b5bf6e))
-   add support for breaking changes in commit summary
    ([22c8ea8](https://github.com/kapsner/autonewsmd/tree/22c8ea87e0618979d2453dccd5483805a117929d))
-   add option to set remote tracking repo
    ([57263db](https://github.com/kapsner/autonewsmd/tree/57263dbc4f12387ce4371e005b961ae661606e0a))

#### Bug fixes

-   fixed issue when only one commit available
    ([1c323d1](https://github.com/kapsner/autonewsmd/tree/1c323d115274b09fe9e05695ed95a89084a3cd6a))
-   fixed reference to type_mappings in private
    ([65ece46](https://github.com/kapsner/autonewsmd/tree/65ece468574594c8377e2db2d621a490af6979cd))

#### Refactorings

-   streamlining r6-code
    ([5e76f61](https://github.com/kapsner/autonewsmd/tree/5e76f611cd1d65600e4050bc33a65bedfb7352df))
-   default interactive answer to na
    ([9962291](https://github.com/kapsner/autonewsmd/tree/9962291181d1e78baba06a6748ab3a64cbab5ae2))
-   commit types to private
    ([e16c7da](https://github.com/kapsner/autonewsmd/tree/e16c7daad2daee2772efda449f067ced3a40f8bf))

#### Tests

-   add unittest for breaking changes
    ([f6fcfa5](https://github.com/kapsner/autonewsmd/tree/f6fcfa5646b7f8b01bb2affce0e5d8ca0b430c96))

#### CI

-   updated tic.yml
    ([1008601](https://github.com/kapsner/autonewsmd/tree/1008601607514c6ed4a6b0f3088aa0a503935158))

#### Docs

-   updated vignette and readme
    ([a8ad163](https://github.com/kapsner/autonewsmd/tree/a8ad163778ec524ce3cf21df026d1f26fd4a6086))
-   specifying bc in readme
    ([7e04e68](https://github.com/kapsner/autonewsmd/tree/7e04e6861f52ad28994a8a3d2b2fa77cfba635da))
-   updated readme
    ([47188a7](https://github.com/kapsner/autonewsmd/tree/47188a747936f6f08524b91acb90845c7dfb9856))
-   ref to readme in vignette
    ([ac12080](https://github.com/kapsner/autonewsmd/tree/ac12080678bbf3f35a62c5b71ec71ef9af870de1))
-   table with commit types and section related packages
    ([98fb4b1](https://github.com/kapsner/autonewsmd/tree/98fb4b1d678c224326833452bf6098ca9459e429))

#### Other changes

-   updated readme
    ([9cce1c8](https://github.com/kapsner/autonewsmd/tree/9cce1c8a3304cec9cceaaf30573b51c516042462))
-   changed order of init arguments
    ([5982a02](https://github.com/kapsner/autonewsmd/tree/5982a0207528b11c1349d3dce2adfa5fc6293334))
-   updated news.md
    ([1bd7b58](https://github.com/kapsner/autonewsmd/tree/1bd7b58f6c072f1f05aead7eb62d65f63c113d7b))
-   importfrom and import statements to zzz.r file
    ([0a6072c](https://github.com/kapsner/autonewsmd/tree/0a6072c3f70542858ece2aa66c8b8760a2cef25c))
-   updated news.md
    ([a7c257b](https://github.com/kapsner/autonewsmd/tree/a7c257b288092a4f29fdd992639668aa9ca51d3b))
-   updated description
    ([73c93e6](https://github.com/kapsner/autonewsmd/tree/73c93e6afc3f8e542abf5e91ba9c322020a7e5a2))
-   updated description
    ([6d7cc1f](https://github.com/kapsner/autonewsmd/tree/6d7cc1f45359163d2b592b0958c5f610078e4aa9))
-   updated news.md
    ([05c8f4c](https://github.com/kapsner/autonewsmd/tree/05c8f4c3eb7ae38ff6eed8ac9c5c6349489f13d2))

Full set of changes:
[`v0.0.3...v0.0.4`](https://github.com/kapsner/autonewsmd/compare/v0.0.3...v0.0.4)

## v0.0.3 (2022-09-03)

#### Bug fixes

-   fix cran errors
    ([48ad848](https://github.com/kapsner/autonewsmd/tree/48ad8480a22cb2a4ef41c7dd3586cbff0b0d3141))

#### Refactorings

-   deleting template file after rendering changelog
    ([7324322](https://github.com/kapsner/autonewsmd/tree/7324322da4384cffac947c7f9354e8c65b6ea78f))

#### Docs

-   fixed typo in readme
    ([1493ad5](https://github.com/kapsner/autonewsmd/tree/1493ad54f96b1ac8930297ae25633bb40aa37447))

#### Other changes

-   updated news.md
    ([3165668](https://github.com/kapsner/autonewsmd/tree/31656683c9e510ee7f78cee8bffc6100a9538a50))

Full set of changes:
[`v0.0.2...v0.0.3`](https://github.com/kapsner/autonewsmd/compare/v0.0.2...v0.0.3)

## v0.0.2 (2022-08-31)

#### New features

-   prompting for user input before writing the changelog file
    ([2cb392e](https://github.com/kapsner/autonewsmd/tree/2cb392e0cfdf6505447f770871252742371ad44d))

#### Bug fixes

-   added importfrom utils askyesno to namespace
    ([3c3a4e2](https://github.com/kapsner/autonewsmd/tree/3c3a4e26f8f33dca021c5cee0d8bc2f8b41b3b84))

#### Tests

-   hot-fix to fix failing unit tests on read-only systems
    ([771a334](https://github.com/kapsner/autonewsmd/tree/771a33466c1e9a7940b9cd544299f696de7d87d0))
-   increasing test coverage
    ([c3b499d](https://github.com/kapsner/autonewsmd/tree/c3b499d8b9b3a3dff76baeaa2ee658e864ae846b))

#### Docs

-   documented con-argument of write
    ([e37f63a](https://github.com/kapsner/autonewsmd/tree/e37f63a761e1cb38c69879c8627398bc3badbb82))
-   added cran installation and cran badges
    ([de3c6bc](https://github.com/kapsner/autonewsmd/tree/de3c6bc2b5a958a8dd2f3d3efd02901a53731073))

#### Other changes

-   updated news.md
    ([33cee50](https://github.com/kapsner/autonewsmd/tree/33cee507c8b2d4d933fa38c095d39394662ffbf6))

Full set of changes:
[`v0.0.1...v0.0.2`](https://github.com/kapsner/autonewsmd/compare/v0.0.1...v0.0.2)

## v0.0.1 (2022-08-27)

#### Bug fixes

-   addressing comments raised during the first submission to cran
    ([fbab006](https://github.com/kapsner/autonewsmd/tree/fbab006658f4a26b4112e5413af5f3da88bd68bb))

#### Tests

-   fixing unit-tests on windows 3
    ([03a28de](https://github.com/kapsner/autonewsmd/tree/03a28deb949360ca900b163166d3bc0de0ba8030))
-   fixing unit-tests on windows 2
    ([fafad0a](https://github.com/kapsner/autonewsmd/tree/fafad0ac6a6a55ea32eefbcab19952e5dffa14e3))
-   fixing unit-tests on windows
    ([f9e9a55](https://github.com/kapsner/autonewsmd/tree/f9e9a55d61ef13fd0e6ce0ac43d612dac8a33ac2))

#### CI

-   add libharfbuzz-dev libfribidi-dev dependencies
    ([0c29e16](https://github.com/kapsner/autonewsmd/tree/0c29e16decfced092530918eb1411064c263754f))
-   added installation of libgit-dev to prerequisites
    ([73b63ea](https://github.com/kapsner/autonewsmd/tree/73b63ea32d255e6f2b697124059e05c4affd9294))

#### Other changes

-   added cran-comments.md
    ([fe41b09](https://github.com/kapsner/autonewsmd/tree/fe41b09a48d99692139253a27b2281badf2710b5))
-   updated description
    ([18b5580](https://github.com/kapsner/autonewsmd/tree/18b558032c7cd5e8619afe7a1da6f0ddbc1fc9b5))
-   fixed typo in vignette
    ([afe84f3](https://github.com/kapsner/autonewsmd/tree/afe84f3748e4c504b90f878c78e4edd2f6c76503))
-   updated badges in readme
    ([2c5e126](https://github.com/kapsner/autonewsmd/tree/2c5e126abdb69978640166ced935601de406e025))
-   added news.md
    ([5c182ee](https://github.com/kapsner/autonewsmd/tree/5c182eedbfd3dd26383aff59663c7e1ab6262973))
-   updated badges to main branch
    ([7c967f3](https://github.com/kapsner/autonewsmd/tree/7c967f3424fdd88390792d3a3053902349974153))

Full set of changes:
[`1455a33...v0.0.1`](https://github.com/kapsner/autonewsmd/compare/1455a33...v0.0.1)
