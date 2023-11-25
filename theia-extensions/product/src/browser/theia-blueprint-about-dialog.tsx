/********************************************************************************
 * Copyright (C) 2020 EclipseSource and others.
 * Copyright (C) 2023 Charles Dong.
 *
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License v. 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * This Source Code may also be made available under the following Secondary
 * Licenses when the conditions for such availability set forth in the Eclipse
 * Public License v. 2.0 are satisfied: GNU General Public License, version 2
 * with the GNU Classpath Exception which is available at
 * https://www.gnu.org/software/classpath/license.html.
 *
 * SPDX-License-Identifier: EPL-2.0 OR GPL-2.0 WITH Classpath-exception-2.0
 ********************************************************************************/

import * as React from 'react';
import { AboutDialog, AboutDialogProps, ABOUT_CONTENT_CLASS } from '@theia/core/lib/browser/about-dialog';
import { injectable, inject } from '@theia/core/shared/inversify';
import { VSXEnvironment } from '@theia/vsx-registry/lib/common/vsx-environment';
import { WindowService } from '@theia/core/lib/browser/window/window-service';

@injectable()
export class TheiaBlueprintAboutDialog extends AboutDialog {

    @inject(VSXEnvironment)
    protected readonly environment: VSXEnvironment;

    @inject(WindowService)
    protected readonly windowService: WindowService;

    protected vscodeApiVersion: string;

    constructor(
        @inject(AboutDialogProps) protected readonly props: AboutDialogProps
    ) {
        super(props);
    }

    protected async doInit(): Promise<void> {
        this.vscodeApiVersion = await this.environment.getVscodeApiVersion();
        super.doInit();
    }

    protected render(): React.ReactNode {
        return <div className={ABOUT_CONTENT_CLASS}>
            {this.renderContent()}
        </div>;
    }

    protected renderContent(): React.ReactNode {
        return <div className='ad-container'></div>;

    }

    protected renderTitle(): React.ReactNode {
        return (
            <div className='gs-header'>
                <h1>Let's Theia</h1>
                <span>An Eclipse Theia distribution</span>
                {this.renderVersion()}
            </div>
        );
    }

    protected renderVersion(): React.ReactNode {
        return (
            <div>
                <p className='gs-sub-header' >
                    {`Version: ${this.applicationInfo?.version ?? 'Unknown'}`}
                </p>

                <p className='gs-sub-header'>
                    {`Eclipse Theia Version: ${this.applicationInfo?.version ?? 'Unknown'}`}
                </p>

                <p className='gs-sub-header' >
                    {'VS Code API Version: ' + this.vscodeApiVersion}
                </p>
            </div>
        );
    }
}
